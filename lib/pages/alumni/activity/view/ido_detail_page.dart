import 'dart:convert';
import 'dart:io';

import 'package:fast_base58/fast_base58.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:slope_solana_client/src/sol/signature.dart';
import 'package:slope_solana_client/src/sol/v1/unknown_program.dart';
import 'package:provider/provider.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart' as solana;
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/alumni/activity/model/ido_model.dart';
import 'package:wallet/pages/alumni/activity/view/ido_approve_page.dart';
import 'package:wallet/pages/connect_browser/from_web_message_model.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/currency_format.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wd_common_package/wd_common_package.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IdoDetailPage extends StatefulWidget {
  final Ido idoItemInfo;

  const IdoDetailPage({Key? key, required this.idoItemInfo}) : super(key: key);

  @override
  _IdoDetailPageState createState() => _IdoDetailPageState();
}

class _IdoDetailPageState extends State<IdoDetailPage>
    with SingleTickerProviderStateMixin {
  late bool _isLoading = true;

  String? pageTitle;

  WebViewController? webViewController;

  String? appBarTitle;

  String inpageJavaScriptCode = '';

  /// js
  Future<void> _loadInPageJs() async {
    final jsCode = await rootBundle.loadString(Assets.assets_inpage_script_js);
    inpageJavaScriptCode = jsCode;
    _injectJsIntoPage();
  }

  @override
  void initState() {
    super.initState();
    _loadInPageJs();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(widget.idoItemInfo.name ?? ''),
      ),
      body: Stack(children: [
        WebView(
          initialUrl: widget.idoItemInfo.linkUrl,
          userAgent: 'Slope IOS, Slope Android',
          onWebViewCreated: (WebViewController controller) => webViewController = controller,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (String url) {
            _injectJsIntoPage();
            setState(() {
              webViewController
                  ?.evaluateJavascript('window.document.title')
                  .then((value) => setState(() {
                appBarTitle = value.replaceAll('"', '');
              }));

              _isLoading = false;
            });
          },

          /// JsFlutter
          javascriptChannels: <JavascriptChannel>[
            JavascriptChannel(
                name: 'slopeApp', // WebslopeApppostMessage
                onMessageReceived: _receiveMessageFromWeb)
          ].toSet(),
        ),
        if (_isLoading)
          LinearProgressIndicator(
            color: appColors.purpleAccent,
            minHeight: 2,
          ),
      ]),
    );
  }

  void _injectJsIntoPage() {
    if (inpageJavaScriptCode.isEmpty) return;
    webViewController?.evaluateJavascript('$inpageJavaScriptCode').then((value) {
      logger.d(value);
    });
  }

  /// js
  void _evalJs(ToWebMessageModel data, {bool isSign = false}) =>
      webViewController?.evaluateJavascript('''
      slopeAppToDapp(${jsonEncode(data.toJson(isSign: isSign))});
    ''');

  void _refreshWebView() {
    webViewController?.reload();
  }

  void _receiveMessageFromWeb(JavascriptMessage message) {
    final String msg = message.message..replaceAll('\n', '');
    final mapMsg = jsonDecode(msg);
    var msgModel = FromWebMessage.fromJson(mapMsg);

    if (msgModel.method == 'connect') {
      WalletEntity? wallet = context.read<WalletMainModel>().currentWallet;

      _evalJs(
        ToWebMessageModel(id: msgModel.id, msg: 'ok', data: ToWebData(publicKey: wallet!.address)),
      );
    } else if (msgModel.method == 'disconnect') {
      _evalJs(ToWebMessageModel(id: msgModel.id, msg: 'ok'));
    } else if (msgModel.method == 'signTransaction') {
      _decodeMessage([msgModel.data!.message], msgModel.id);
    } else if (msgModel.method == 'signAllTransactions' && msgModel.data!.message is List) {
      _decodeMessage(msgModel.data!.message, msgModel.id);
    }
  }

  AppColors get appColors => context.read<AppTheme>().currentColors;

  Future<void> _decodeMessage(List<String> messages, String? id) async {
    showLoading(maskType: EasyLoadingMaskType.black, dismissOnTap: true);

    WalletEntity? wallet = context.read<WalletMainModel>().currentWallet;
    late final List<List<DecodeInstructionData>> res;
    try {
      res = await Future.wait(messages
          .map((e) async =>
      await decodeMessage(wallet!.address, Base58Decode(e)))
          .toList());
    } catch (e) {
      logger.d('decode Message Error: $e');
    } finally {
      EasyLoading.dismiss();
    }

    _showApproveTransactionDialog(wallet, res, id,
        messages.map<List<int>>((m) => Base58Decode(m)).toList());
  }

  Map<String, dynamic> _parseInstruction(DecodeInstructionData d) {
    late final List<Widget> body;
    String labels = 'Unknown Instruction';

    switch (d.type) {
      case '':
        body = [];
        break;
      case 'Unknown':
      case 'unknown':
        UnknownProgram dd = d.data;

        body = [
          _bodyRowBuilder('Program', dd.program),
          _bodyRowBuilder('Data', dd.data, noPadding: true),
        ];
        break;
      case 'systemCreate':
        labels = 'Create account';
        logger.d('$labels :');
        CreateAccountParams dd = d.data;

        body = [
          _bodyRowBuilder('To', dd.newAccountPubkey),
          _bodyRowBuilder('Lamports', dd.lamports, noPadding: true),
        ];

        logger.d('    To    ${dd.newAccountPubkey}');
        logger.d('    Lamports    ${dd.lamports}');
        break;
      case 'systemCreateWithSeed':
        labels = 'Create account with seed';
        logger.d('$labels :');
        CreateAccountWithSeedParams dd = d.data;

        body = [
          _bodyRowBuilder('Base', dd.basePubkey),
          _bodyRowBuilder('New account', dd.newAccountPubkey),
          _bodyRowBuilder('Seed', dd.seed),
          _bodyRowBuilder('Lamports', dd.lamports.toString(), noPadding: true),
        ];

        logger.d('    Base    ${dd.basePubkey}');
        logger.d('    New account    ${dd.newAccountPubkey}');
        logger.d('    Seed    ${dd.seed}');
        logger.d('    Lamports    ${dd.lamports}');
        break;
      case 'systemTransfer':
        labels = 'Transfer SOL';
        logger.d('$labels :');
        TransferParams dd = d.data;

        body = [
          _bodyRowBuilder('To', dd.toPubkey),
          _bodyRowBuilder('Lamports', dd.lamports.toString(), noPadding: true),
        ];

        logger.d('    To    ${dd.toPubkey}');
        logger.d('    Lamports    ${dd.lamports}');
        break;
      case 'stakeAuthorizeWithSeed':
        labels = 'Stake authorize with seed';
        logger.d('$labels :');
        AuthorizeWithSeedStakeParams dd = d.data;

        body = [
          _bodyRowBuilder('Stake', dd.stakePubkey),
          _bodyRowBuilder('Authority base', dd.authorityBase),
          _bodyRowBuilder('Authority seed', dd.authoritySeed),
          _bodyRowBuilder('Authority owner', dd.authorityOwner),
          _bodyRowBuilder('New authorized', dd.newAuthorizedPubkey),
          _bodyRowBuilder('Stake authorization type', dd.stakeAuthorizationType.toString()),
          _bodyRowBuilder('Custodian', dd.custodianPubkey, noPadding: true),
        ];

        logger.d('    Stake    ${dd.stakePubkey}');
        logger.d('    Authority base    ${dd.authorityBase}');
        logger.d('    Authority seed    ${dd.authoritySeed}');
        logger.d('    Authority owner    ${dd.authorityOwner}');
        logger.d('    New authorized    ${dd.newAuthorizedPubkey}');
        logger.d('    Stake authorization type    ${dd.stakeAuthorizationType}');
        logger.d('    Custodian    ${dd.custodianPubkey}');
        break;
      case 'stakeAuthorize':
        labels = 'Stake authorize';
        logger.d('$labels :');
        AuthorizeStakeParams dd = d.data;

        body = [
          _bodyRowBuilder('Stake', dd.stakePubkey),
          _bodyRowBuilder('Authorized', dd.authorizedPubkey),
          _bodyRowBuilder('New authorized', dd.newAuthorizedPubkey),
          _bodyRowBuilder('Stake authorization type', dd.stakeAuthorizationType.toString()),
          _bodyRowBuilder('Custodian', dd.custodianPubkey, noPadding: true),
        ];

        logger.d('    Stake   ${dd.stakePubkey}');
        logger.d('    Authorized    ${dd.authorizedPubkey}');
        logger.d('    New authorized    ${dd.newAuthorizedPubkey}');
        logger.d('    Stake authorization type    ${dd.stakeAuthorizationType}');
        logger.d('    Custodian    ${dd.custodianPubkey}');
        break;
      case 'stakeDeactivate':
        labels = 'Deactivate stake';
        logger.d('$labels :');
        DeactivateStakeParams dd = d.data;
        body = [
          _bodyRowBuilder('Stake', dd.stakePubkey),
          _bodyRowBuilder('Authorized', dd.authorizedPubkey, noPadding: true),
        ];
        logger.d('    Stake   ${dd.stakePubkey}');
        logger.d('    Authorized    ${dd.authorizedPubkey}');
        break;
      case 'stakeDelegate':
        labels = 'Delegate stake';
        logger.d('$labels :');
        DelegateStakeParams dd = d.data;

        body = [
          _bodyRowBuilder('Stake', dd.stakePubkey),
          _bodyRowBuilder('Authorized', dd.authorizedPubkey),
          _bodyRowBuilder('Vote', dd.votePubkey, noPadding: true),
        ];

        logger.d('    Stake   ${dd.stakePubkey}');
        logger.d('    Authorized    ${dd.authorizedPubkey}');
        logger.d('    Vote    ${dd.votePubkey}');
        break;
      case 'stakeInitialize':
        labels = 'Initialize stake';
        logger.d('$labels :');
        InitializeStakeParams dd = d.data;

        body = [
          _bodyRowBuilder('Stake', dd.stakePubkey),
          _bodyRowBuilder('Authorized', dd.authorized, noPadding: true),
        ];

        logger.d('    Stake   ${dd.stakePubkey}');
        logger.d('    Authorized    ${dd.authorized}');
        // logger.d('    Vote    ${dd.votePubkey}');
        break;
      case 'stakeSplit':
        labels = 'Split stake';
        logger.d('$labels :');
        SplitStakeParams dd = d.data;

        body = [
          _bodyRowBuilder('Stake', dd.stakePubkey),
          _bodyRowBuilder('Authorized', dd.authorizedPubkey),
          _bodyRowBuilder('Split to', dd.splitStakePubkey),
          _bodyRowBuilder('Lamports', dd.lamports, noPadding: true),
        ];

        logger.d('    Stake   ${dd.stakePubkey}');
        logger.d('    Authorized    ${dd.authorizedPubkey}');
        logger.d('    Split to    ${dd.splitStakePubkey}');
        logger.d('    Lamports    ${dd.lamports}');
        break;
      case 'stakeWithdraw':
        labels = 'Withdraw stake';
        logger.d('$labels :');
        WithdrawStakeParams dd = d.data;

        body = [
          _bodyRowBuilder('Stake', dd.stakePubkey),
          _bodyRowBuilder('Authorized', dd.authorizedPubkey),
          _bodyRowBuilder('Lamports', dd.lamports),
          _bodyRowBuilder('Custodian', dd.custodianPubkey, noPadding: true),
        ];

        logger.d('    Stake   ${dd.stakePubkey}');
        logger.d('    Authorized    ${dd.authorizedPubkey}');
        // logger.d('    Split to    ${dd.toPubkey}');
        logger.d('    Lamports    ${dd.lamports}');
        logger.d('    Custodian    ${dd.custodianPubkey}');

        break;
      case 'initializeMint':
        labels = 'Initialize mint';
        logger.d('$labels :');
        InitializeMint dd = d.data;

        body = [
          _bodyRowBuilder('Decimals', dd.decimals),
          _bodyRowBuilder('Mint authority', dd.mintAuthority, noPadding: true),
        ];

        logger.d('    Decimals   ${dd.decimals}');
        logger.d('    Mint authority   ${dd.mintAuthority}');
        break;
      case 'initializeAccount':
        labels = 'Initialize account';
        logger.d('$labels :');
        InitializeAccount dd = d.data;

        body = [
          _bodyRowBuilder('Mint', dd.mint),
          _bodyRowBuilder('Owner', dd.owner, noPadding: true),
        ];

        logger.d('    Mint   ${dd.mint}');
        logger.d('    Owner   ${dd.owner}');
        break;
      case 'transfer':
        labels = 'Transfer';
        logger.d('$labels :');
        Transfer dd = d.data;

        body = [
          _bodyRowBuilder('Source', dd.source),
          _bodyRowBuilder('Destination', dd.destination),
          _bodyRowBuilder('Owner', dd.owner),
          _bodyRowBuilder('Amount', dd.amount, noPadding: true),
        ];

        logger.d('    Source   ${dd.source}');
        logger.d('    Destination   ${dd.destination}');
        logger.d('    Owner   ${dd.owner}');
        logger.d('    Amount   ${dd.amount}');
        break;
      case 'approve':
        labels = 'Approve';
        logger.d('$labels :');
        Approve dd = d.data;

        body = [
          _bodyRowBuilder('Source', dd.source),
          _bodyRowBuilder('Delegate', dd.delegate),
          _bodyRowBuilder('Owner', dd.owner),
          _bodyRowBuilder('Amount', dd.amount, noPadding: true),
        ];

        logger.d('    Source   ${dd.source}');
        logger.d('    Delegate   ${dd.delegate}');
        logger.d('    Owner   ${dd.owner}');
        logger.d('    Amount   ${dd.amount}');
        break;
      case 'revoke':
        labels = 'Revoke';
        logger.d('$labels :');
        Revoke dd = d.data;

        body = [
          _bodyRowBuilder('Source', dd.source),
          _bodyRowBuilder('Owner', dd.owner, noPadding: true),
        ];

        logger.d('    Source   ${dd.source}');
        logger.d('    Owner   ${dd.owner}');
        break;
      case 'mintTo':
        labels = 'Mint to';
        logger.d('$labels :');
        MintTo dd = d.data;

        body = [
          _bodyRowBuilder('Mint', dd.mint),
          _bodyRowBuilder('Destination', dd.destination),
          _bodyRowBuilder('Mint authority', dd.mintAuthority),
          _bodyRowBuilder('Amount', dd.amount, noPadding: true),
        ];

        logger.d('    Mint   ${dd.mint}');
        logger.d('    Destination   ${dd.destination}');
        logger.d('    Mint authority   ${dd.mintAuthority}');
        logger.d('    Amount   ${dd.amount}');
        break;
      case 'closeAccount':
        labels = 'Close account';
        logger.d('$labels :');
        CloseAccount dd = d.data;

        body = [
          _bodyRowBuilder('Source', dd.source),
          _bodyRowBuilder('Destination', dd.destination),
          _bodyRowBuilder('Owner', dd.owner, noPadding: true),
        ];

        logger.d('    Source   ${dd.source}');
        logger.d('    Destination   ${dd.destination}');
        logger.d('    Owner   ${dd.owner}');
        break;
      case 'newOrder':
        labels = 'Place order';
        logger.d('$labels :');
        NewOrder dd = d.data;
        logger.d('    Side   ${dd.side}');

        body = [
          _bodyRowBuilder('Price', dd.limitPrice),
          _bodyRowBuilder('Quantity', dd.maxQuantity),
          _bodyRowBuilder('Type', dd.maxQuantity),
          _bodyRowBuilder('Owner', dd.ownerPubkey, noPadding: true),
        ];

        logger.d('    Price   ${dd.limitPrice}');
        logger.d('    Quantity   ${dd.maxQuantity}');
        logger.d('    Type   ${dd.maxQuantity}');
        logger.d('    Owner   ${dd.ownerPubkey}');
        break;
      case 'settleFunds':
        labels = 'Settle funds';
        logger.d('$labels :');
        SettleFunds dd = d.data;

        body = [
          _bodyRowBuilder('Base wallet', dd.basePubkey),
          _bodyRowBuilder('Quote wallet', dd.quotePubkey, noPadding: true),
        ];

        logger.d('    Base wallet   ${dd.basePubkey}');
        logger.d('    Quote wallet   ${dd.quotePubkey}');
        break;
      case 'matchOrders':
        labels = 'Match orders';
        logger.d('$labels :');
        MatchOrders dd = d.data;

        body = [
          _bodyRowBuilder('Market', dd.market),
          _bodyRowBuilder('Limit', dd.limit, noPadding: true),
        ];

        logger.d('    Market   ${dd.market}');
        logger.d('    Limit   ${dd.limit}');
        break;
      case 'newOrderV3':
        labels = 'Place order';
        logger.d('$labels :');
        NewOrderV3 dd = d.data;

        body = [
          _bodyRowBuilder('Side', dd.side),
          _bodyRowBuilder('Price', dd.limitPrice),
          _bodyRowBuilder('Limit', dd.limit),
          _bodyRowBuilder('baseQuantity', dd.maxBaseQuantity),
          _bodyRowBuilder('QuoteQuantity', dd.maxQuoteQuantity),
          _bodyRowBuilder('selfTradeBehavior', dd.selfTradeBehavior),
          _bodyRowBuilder('Owner', dd.ownerPubkey, noPadding: true),
        ];

        logger.d('    Side   ${dd.side}');
        logger.d('    Price   ${dd.limitPrice}');
        logger.d('    Limit   ${dd.limit}');
        logger.d('    baseQuantity   ${dd.maxBaseQuantity}');
        logger.d('    QuoteQuantity   ${dd.maxQuoteQuantity}');
        logger.d('    selfTradeBehavior   ${dd.selfTradeBehavior}');
        logger.d('    Owner   ${dd.ownerPubkey}');
        break;
    }

    return {'body': body, 'label': labels};
  }

  Widget _bodyRowBuilder(String h, dynamic b, {bool noPadding = false}) => Padding(
    padding: EdgeInsets.only(bottom: noPadding ? 0 : 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          h,
          style: TextStyle(fontSize: 14, height: 1.28, color: appColors.textColor2),
        ),
        Flexible(
            child: Text(
              '${b is num ? CurrencyFormat.formatBalance(b) : _middleEllipsis(b)}',
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 14, height: 1.28, color: appColors.textColor1),
            ))
      ],
    ),
  );

  ///
  String _middleEllipsis(String b) {
    if (b.length > 20) {
      return '${b.substring(0, 5)}...${b.substring(b.length - 5)}';
    }

    return b;
  }

  Text _headBuilder(String t) => Text(
    t,
    textAlign: TextAlign.start,
    style: TextStyle(
        fontSize: 16, height: 1.25, fontWeight: FontWeight.bold, color: appColors.textColor1),
  );

  Widget _buildInstruction(DecodeInstructionData d) {
    final parsed = _parseInstruction(d);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.symmetric(horizontal: 24).add(EdgeInsets.only(bottom: 16)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: context.isLightTheme ? Color(0xfff3f3f5) : Color(0xff242628), width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _headBuilder(parsed['label']),
          SizedBox(
            height: 16,
          ),
          ...parsed['body']
        ],
      ),
    );
  }

  Widget _buildTransactionTitle(String index) => Text(
    'Transaction $index',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );

  Future<List<List<int>>> _signMessages(WalletEntity? wallet,
      {required List<List<int>> base58DecodedMessages}) async {
    final privateKey = wallet!.decryptPrivateKey();

    final account =
        (await MySolanaWallet().importWalletPrivateKey(privateKey)).solanaAccountList.first;

    final temp = base58DecodedMessages.map((e) async {
      final s = solana.Signature.from(
          await sign(e, Signature(keyPair: account.keyPair, publicKey: account.strXPUB).keyPair));
      return s.serialize();
    }).toList();

    return Future.wait(temp);
  }

  void _showApproveTransactionDialog(
      WalletEntity? wallet,
      List<List<DecodeInstructionData>> decodeInstructionDatas,
      String? id,
      List<List<int>> base58DecodedMessages) {
    final List<List<Widget>> transactionWidgets = decodeInstructionDatas
        .map<List<Widget>>(
          (decodeInstructionData) =>
          decodeInstructionData.map((e) => _buildInstruction(e)).toList(),
    )
        .toList();

    List<Widget> transactionInfo = transactionWidgets.reduce((value, element) {
      if (transactionWidgets.length > 1) {
        if (transactionWidgets.indexOf(value) == 0) {
          value.insert(0, _buildTransactionTitle('1'));
        }
        value.add(_buildTransactionTitle((transactionWidgets.indexOf(element) + 1).toString()));
      }
      return [...value, ...element];
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => IdoApprovePage(
                siteInfo: this.widget.idoItemInfo,
                appColors: appColors,
                isLightTheme: context.isLightTheme,
                transactionInfo: transactionInfo,
                cancelCallback: () {
                  _evalJs(ToWebMessageModel(id: id, msg: 'cancel'));
                },
                approveCallback: () async {
                  final signatures =
                  await _signMessages(wallet, base58DecodedMessages: base58DecodedMessages);

                  final base58EncodedSign = signatures.map((e) => Base58Encode(e)).toList();

                  _evalJs(
                      ToWebMessageModel(
                          id: id,
                          msg: 'ok',
                          data: ToWebData(
                              publicKey: wallet!.address,
                              signature: base58EncodedSign.first,
                              signatures: base58EncodedSign)),
                      isSign: true);

                  // Navigator.pop(context);
                })));
  }
}

