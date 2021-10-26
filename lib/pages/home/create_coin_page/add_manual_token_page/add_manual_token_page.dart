import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/home/create_coin_page/widget/create_coin_model.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wd_common_package/wd_common_package.dart';

class AddManualTokenPage extends StatefulWidget {
  const AddManualTokenPage({Key? key}) : super(key: key);

  @override
  _AddManualTokenPageState createState() => _AddManualTokenPageState();
}

class _AddManualTokenPageState extends State<AddManualTokenPage> {
  AppColors get _appColors => AppTheme.of(context).currentColors;

  TextEditingController _contractText = TextEditingController(text: '');

  TextEditingController _symbolText = TextEditingController(text: '');
  TextEditingController _deciamlText = TextEditingController(text: '18');

  /// ;
  final ValueNotifier<bool> _initShowContractErrorHint = ValueNotifier(false);

  final ValueNotifier<bool> _initShowSymbolErrorHint = ValueNotifier(false);

  double _bottom = 0.0;

  @override
  void initState() {
    _createCoinModel = CreateCoinModel();
    super.initState();
    _getSolanaToken();
    _getContractList();
  }

  late CreateCoinModel _createCoinModel;

  Future _getSolanaToken() async {
    await _createCoinModel.getSolanaToken();
  }

  List<CoinEntity> _contractList = [];

  void _getContractList() async {
    var result = await WalletMainModel.instance.getContractList();

    if (result.isNotEmpty) {
      _contractList = result.toList();
    }
  }

  @override
  Widget build(BuildContext _context) {
    _bottom = MediaQuery.of(context).viewPadding.bottom;
    return ChangeNotifierProvider<CreateCoinModel>(
      create: (_) => _createCoinModel,
      child: Scaffold(
        bottomSheet: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: buildAddButton(context, _context),
            );
          },
        ),
        appBar: WalletBar(
          showBackButton: true,
          title: Text('Add Manual Token'),
        ),
        body: buildBuilder(_context),
        // body: ChangeNotifierProvider<CreateCoinModel>(
        //   create: (_) => _createCoinModel,
        //   child: buildBuilder(),
        // ),
      ),
    );
  }

  Builder buildBuilder(BuildContext _context) {
    return Builder(builder: (BuildContext context) {
      return ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          /// ;
          buildContractInput(context),

          const SizedBox(height: 24),

          /// Symbol;
          buildSymbolInput(context),

          const SizedBox(height: 24),


          /// Symbol;
          buildDecimalInput(context),

          SizedBox(
            height: MediaQuery.of(_context).viewInsets.bottom > 0 ? 56 + MediaQuery.of(_context).viewPadding.bottom +MediaQuery.of(_context).viewInsets.bottom+ 16 : 0,
          ),

        ],
      );
    });
  }

  CoinEntity? _customCoin;

  ///  ;
  ///  builder，contextwidgetcontext,
  ///
  Widget buildAddButton(BuildContext context, BuildContext _context) {
    List<CoinEntity> _findResultContractList =
        context.select((CreateCoinModel value) => value.getFindContractList);
    String searchContractText = context.select((CreateCoinModel value) => value.searchContractText);
    bool isNotClick = _customCoin != null && searchContractText.isNotEmpty;
    MaterialStateProperty<Color> btnBackground = isNotClick
        ? MaterialStateProperty.all(AppTheme.of(context).currentColors.purpleAccent)
        : MaterialStateProperty.all(
            AppTheme.of(context).currentColors.purpleAccent.withOpacity(0.4));
    return Opacity(
        opacity: isNotClick ? 1 : 0.5,
        child: Container(
          width: double.infinity,
          height: 56,
          margin: EdgeInsets.only(
              bottom: (MediaQuery.of(_context).viewInsets.bottom > 0 ? 0 : _bottom) + 16),
          // margin: EdgeInsets.only(bottom: !(MediaQuery.of(context).viewInsets.bottom> 0)?MediaQuery.of(context).padding.bottom:0 +16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: ValueListenableBuilder(
              valueListenable: _initShowContractErrorHint,
              builder: (context, value, child) {
                return IgnorePointer(
                  ignoring: !isNotClick,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      backgroundColor: MaterialStateProperty.all(context.appColors.purpleAccent),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
                    ),
                    child: Text(
                      'Add',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () async {
                      if (_symbolText.text.isEmpty) {
                        showToast('Please enter the token symbol.', duration: Duration(seconds: 3));
                        return;
                      }
                      if (_deciamlText.text.isEmpty) {
                        showToast('Please enter the token decimal.', duration: Duration(seconds: 3));
                        return;
                      }

                      if (_isAloneCoinNotifier.value) {
                        _customCoin!.decimals = int.parse(_deciamlText.text);
                        _customCoin!.coin = _symbolText.text;
                      }

                      // logger.d('_customCoin!.coin:${_customCoin!.coin}');
                      // logger.d('_customCoin!.decimals:${_customCoin!.decimals}');
                      WalletEntity? wallet = WalletMainModel.instance.currentWallet;
                      List<CoinEntity> coinList = wallet?.coins ?? [];

                      /// ;
                      CoinEntity? isContractListHas = _contractList.firstWhereOrNull(
                          (element) => element.contractAddress == _customCoin!.contractAddress);

                      /// 
                      CoinEntity? isCustomContainCoin = _createCoinModel
                          .getCacheCustomCoin(walletAddress: wallet!.address)
                      .firstWhereOrNull((element) =>
                          element.contractAddress ==
                          _customCoin!.contractAddress);
                      /// token;
                  CoinEntity? localCoin = coinList.firstWhereOrNull((element) =>
                  element.contractAddress == _customCoin!.contractAddress);
                      // logger.d('_customCoin!.contractAddress:${_customCoin!.contractAddress}');
                      // logger.d('isContractListHas:${isContractListHas}');
                      // logger.d('isCustomContainCoin:${isCustomContainCoin}');
                      // logger.d('localCoin.hide:${localCoin!.hide}');
                      if (localCoin != null && !localCoin.hide) {
                        showToast('This token has already been added, please check the token list.',
                            duration: Duration(seconds: 3));
                        return;
                      }

                      if (isContractListHas != null || isCustomContainCoin != null) {
                        showToast('This token has already been added, please check the token list.',
                            duration: Duration(seconds: 3));
                        return;
                      }

                      try {
                        if (null != wallet) {
                          _customCoin!.splAddress = MySolanaWallet()
                              .createAccountSpl(_customCoin!.contractAddress, wallet.address);
                        }
                      } finally {
                        if (_customCoin!.splAddress.isEmpty) {
                          //
                          _customCoin!.splAddress = 'Local';
                        }
                      }
                      _customCoin!.isSelected = true;

                      _customCoin!.hide = false;
                      if (null == localCoin) {
                        coinList.add(_customCoin!);
                      } else {
                        if (localCoin.hide==true) {
                          localCoin.hide = false;
                        }
                        _customCoin?.coin = _symbolText.text;
                        localCoin.coin = _symbolText.text;

                      }

                      WalletMainModel.instance
                        // 
                        ..updateWallet(wallet)
                        // 
                        ..getCurrentWalletUsdtBalance();

                      // logger.d('_customCoin222:${_customCoin!.decimals}');

                      /// ;
                      _createCoinModel.setCacheCustomCoin(
                          walletAddress: wallet.address, data: _customCoin!);
                      Navigator.maybePop(context);
                    },
                  ),
                );
              }),
        ));
  }

  void _textChange() async {
    if (_createCoinModel.getFindContractList.length == 1) {
      _customCoin = _createCoinModel.getFindContractList.first;
      _symbolText.text = _customCoin!.coin;
      _deciamlText.text = _customCoin!.decimals.toString();
      _isAloneCoinNotifier.value = false;
      _initShowContractErrorHint.value = false;
      return;
    } else {
      try {
        final accountInfo =
            await SolanaClient(SAMOURAI_API).getAccountInfo(_contractText.text.trim());
        String program = accountInfo.data['program'];
        String type = accountInfo.data['parsed']['type'];
        bool isInitialized = accountInfo.data['parsed']['info']['isInitialized'];
        if (program == "spl-token" && type == 'mint' && isInitialized) {
          _customCoin = CoinEntity();
          _initShowContractErrorHint.value = false;
          _customCoin!.decimals = 0;
          _deciamlText.text = '18';
          _customCoin!.contractAddress = _contractText.text;
          setState(() {});
          return;
        }
      } catch (e) {}
    }
    _symbolText.clear();
    _deciamlText.clear();
    _customCoin = null;
    _initShowContractErrorHint.value = true;
    _isAloneCoinNotifier.value = true;
    setState(() {});
  }

  Timer? timer;

  /// symbol, decimal;
  ValueNotifier<bool> _isAloneCoinNotifier = ValueNotifier(true);

  /// ;
  Column buildContractInput(BuildContext context) {
    bool _searchContractTextIsNotEmpty =
        context.select((CreateCoinModel value) => value.searchContractTextIsNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Contract',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: _appColors.textColor1,
              height: 20 / 16),
        ),
        const SizedBox(height: 8),
        Container(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _appColors.dividerColor, width: 1),
          ),
          child: TextField(
            autocorrect: false,
            enableSuggestions: false,
            controller: _contractText,
            cursorColor: AppTheme.of(context).currentColors.purpleAccent,
            onChanged: (value) async {
              timer?.cancel();

              timer = Timer(Duration(milliseconds: 500), () {
                _createCoinModel.setFindContractText = value.trim();
                if (_createCoinModel.searchContractText.isEmpty) return;
                _textChange();
              });
            },
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              color: _appColors.textColor1,
            ),

            // cursorHeight: 20,
            decoration: InputDecoration(
              hintText: 'Please enter the token contract',
              hintStyle: TextStyle(
                height: 22 / 14,
                fontSize: 14,
                color: _appColors.textColor3,
              ),
              contentPadding: const EdgeInsets.only(top: 8, left: 16),
              suffixIcon: Visibility(
                visible: _searchContractTextIsNotEmpty,
                child: GestureDetector(
                  onTap: () {
                    _createCoinModel.setFindContractText = '';
                    _contractText.clear();
                    _symbolText.clear();
                    _deciamlText.clear();
                    _createCoinModel.setFindSymbolText = '';
                    _customCoin = null;
                    _initShowContractErrorHint.value = true;
                    _isAloneCoinNotifier.value = true;
                  },
                  child: service.svg.asset(Assets.assets_svg_cleantext_svg,
                      fit: BoxFit.scaleDown, color: _appColors.textColor4),
                ),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<bool>(
          valueListenable: _initShowContractErrorHint,
          builder: (c, contractVerify, child) {
            return Visibility(
              visible: _customCoin == null &&
                  contractVerify &&
                  _createCoinModel.searchContractText.isNotEmpty,
              child: Text(
                  'Token information is not found, please check whether the contract is correct',
                  style: TextStyle(
                    fontSize: 12,
                    color: _appColors.redAccent,
                    height: 16 / 12,
                  )),
            );
          },
        ),
      ],
    );
  }

  Column buildDecimalInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Decimal',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: _appColors.textColor1,
              height: 20 / 16),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _appColors.dividerColor, width: 1),
          ),
          child: ValueListenableBuilder<bool>(
              valueListenable: _isAloneCoinNotifier,
              builder: (context, isAloneCoinNotifier, _) {
                return TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  enabled: isAloneCoinNotifier,
                  enableSuggestions: false,
                  controller: _deciamlText,
                  cursorColor: AppTheme.of(context).currentColors.purpleAccent,
                  onChanged: (value) {},
                  maxLines: 10,
                  style: TextStyle(
                    fontSize: 14,
                    color: _appColors.textColor1,
                  ),
                  // cursorHeight: 20,
                  decoration: InputDecoration(
                    hintText: '',
                    hintStyle: TextStyle(
                      height: 22 / 14,
                      fontSize: 14,
                      color: _appColors.textColor3,
                    ),
                    contentPadding: const EdgeInsets.only(
                      top: 8,
                      left: 16,
                      right: 16,
                    ),
                    border: InputBorder.none,
                  ),
                );
              }),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget buildSymbolInput(BuildContext context) {
    String searchSymbolText = context.select((CreateCoinModel value) => value.searchSymbolText);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Symbol',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: _appColors.textColor1,
              height: 20 / 16),
        ),
        const SizedBox(height: 8),
        Container(
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: _appColors.dividerColor, width: 1),
          ),
          child: ValueListenableBuilder<bool>(
              valueListenable: _isAloneCoinNotifier,
              builder: (context, isAloneCoinNotifier, c) {
                return Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text('${_symbolText.text.length}/20',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 22 / 14,
                            color: _appColors.textColor4,
                          )),
                    ),
                    TextField(
                      enabled: isAloneCoinNotifier,
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: _symbolText,
                      cursorColor: AppTheme.of(context).currentColors.purpleAccent,
                      onChanged: (value) {
                        _createCoinModel.setFindSymbolText = value;
                        if (value.isNotEmpty) {
                          _initShowSymbolErrorHint.value = true;
                        } else {
                          _initShowSymbolErrorHint.value = false;
                        }
                      },
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: _appColors.textColor1,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(20) //
                      ],
                      decoration: InputDecoration(
                        hintText: 'Please enter the token symbol',
                        hintStyle: TextStyle(
                          height: 22 / 14,
                          fontSize: 14,
                          color: _appColors.textColor3,
                        ),
                        contentPadding: EdgeInsets.only(
                          top: -6,
                          left: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                );
              }),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
