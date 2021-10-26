import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:slope_solana_client/src/bean/transaction.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wd_common_package/wd_common_package.dart';

import 'transaction_detail_page.dart';
import 'tx_instruction_ext.dart';

void openTransactionPage(String txId) {
  final url = 'https://solscan.io/tx/$txId';
  service.router.pushNamed(RouteName.webViewPage, arguments: url);
}

class TxRecord extends StatelessWidget {
  final MyConfirmedTransactionWithTXID transaction;
  final MyTxInstruction? txInstruction;
  final CoinEntity token;

  const TxRecord({
    Key? key,
    required this.transaction,
    required this.token,
    this.txInstruction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;

    var txType = txInstruction?.getTxType(token.splAddress) ?? TxType.Success;
    String coinSize = txInstruction.uiAmount;

    String txIcon;
    if (txType == TxType.Send) {
      txIcon = context.isLightTheme
          ? Assets.assets_svg_ic_transaction_send_light_svg
          : Assets.assets_svg_ic_transaction_send_dark_svg;
    } else if (txType == TxType.Receive) {
      txIcon = context.isLightTheme
          ? Assets.assets_svg_ic_transaction_receive_light_svg
          : Assets.assets_svg_ic_transaction_receive_dark_svg;
    } else {
      txIcon = context.isLightTheme
          ? Assets.assets_svg_ic_transaction_success_light_svg
          : Assets.assets_svg_ic_transaction_success_dark_svg;
    }

    String timeFormat;
    if (DateTime.now().year == transaction.dateTime.year) {
      timeFormat = 'MM-dd HH:mm:ss';
    } else {
      timeFormat = 'y-MM-dd HH:mm:ss';
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (txInstruction is MyTransferTx || txInstruction is MyTransferTxSpl) {
          var route = BaseRoute<Object>(builder: (context, settings) {
            return TransactionDetailPage(
              transaction: transaction,
              txInstruction: txInstruction!,
              token: token,
            );
          });
          service.router.push<Object>(route.getRoute(RouteSettings())!);
        } else if (txType == TxType.Success) {
          openTransactionPage(transaction.signature);
          // showToast(
          //     'Currently, only the transaction details of sending & receiving SPL tokens can be viewed, and transaction details such as NFT and SWAP are not supported.');
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        height: 72,
        decoration: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 1,
            color: context.appColors.dividerColor,
          ),
          insets: const EdgeInsets.only(left: 40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  service.svg.asset(txIcon),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        txType == TxType.Send
                            ? 'Send'
                            : txType == TxType.Receive
                                ? 'Receive'
                                : 'Success',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500, color: appColors.textColor1),
                      ),
                      Text(
                        DateFormat(timeFormat).format(transaction.dateTime),
                        style: TextStyle(
                          fontSize: 12,
                          color: appColors.textColor3,
                          height: 16 / 12,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Visibility(
                        visible: txType != TxType.Success,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            '${txType == TxType.Send ? '-' : '+'}$coinSize',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: txType == TxType.Send ? appColors.textColor1 : appColors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: transaction.signature));
                          showToast("Copy success!");
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          height: 16,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'TXID: ',
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: appColors.textColor3,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Flexible(
                                child: Text(
                                  transaction.signature,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: appColors.textColor3,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              service.svg.asset(
                                Assets.assets_svg_copy_txid_svg,
                                width: 16,
                                height: 16,
                                color: appColors.textColor3,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
