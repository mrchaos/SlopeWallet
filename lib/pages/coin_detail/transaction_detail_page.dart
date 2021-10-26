import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:slope_solana_client/src/bean/transaction.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/coin_detail/tx_record.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/currency_format.dart';
import 'package:wallet/widgets/loading/loading_util.dart';

import 'tx_instruction_ext.dart';

class TransactionDetailPage extends StatelessWidget {
  final MyTxInstruction txInstruction;
  final MyConfirmedTransactionWithTXID transaction;
  final CoinEntity token;

  const TransactionDetailPage({
    Key? key,
    required this.txInstruction,
    required this.transaction,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const timeFormat = 'y-MM-dd HH:mm:ss';

    return Scaffold(
      appBar: WalletBar.backWithTitle('Details'),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          service.svg.asset(
            context.isLightTheme
                ? Assets.assets_svg_ic_tx_success_light_svg
                : Assets.assets_svg_ic_tx_success_dark_svg,
          ),
          const SizedBox(height: 8),
          Text(
            'Success',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 20 / 16,
              fontWeight: FontWeight.w500,
              color: context.appColors.textColor1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat(timeFormat).format(transaction.dateTime),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              height: 16 / 12,
              fontWeight: FontWeight.w400,
              color: context.appColors.textColor3,
            ),
          ),
          const SizedBox(height: 16),
          buildCard([
            buildKeyValue(
              key: 'Amount',
              value:
                  '${txInstruction.getTxType(token.splAddress) == TxType.Send ? '-' : '+'}${txInstruction.uiAmount} ${token.coin}',
              valueStyle: TextStyle(fontWeight: FontWeight.w500),
            ),
          ]),
          const SizedBox(height: 16),
          buildCard([
            buildKeyValue(key: 'From', value: txInstruction.source.ellAddress()),
            buildKeyValue(key: 'To', value: txInstruction.destination.ellAddress()),
            buildRow(
              key: 'Fee',
              value: Text(
                '${CurrencyFormat.formatDecimal(Decimal.fromInt((transaction.meta?.fee ?? 5000)) / Decimal.fromInt(LAMPORTS_PER_SOL))} SOL ',
                style: TextStyle(
                  color: context.appColors.textColor3,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 16),
          buildCard([
            buildRow(
              key: 'TXID',
              value: InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: transaction.signature));
                  showToast("Copy success!");
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        transaction.signature,
                        style: TextStyle(
                          color: context.appColors.textColor3,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    service.svg.asset(
                      Assets.assets_svg_wallet_copy_svg,
                      color: context.appColors.textColor3,
                      width: 16,
                    ),
                  ],
                ),
              ),
            ),
            buildKeyValue(key: 'To', value: txInstruction.destination.ellAddress()),
            buildRow(
              key: 'Query Details',
              value: InkWell(
                onTap: () {
                  openTransactionPage(transaction.signature);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Go Solscan',
                      style: TextStyle(
                        fontSize: 14,
                        color: context.appColors.textColor1,
                      ),
                    ),
                    service.svg.asset(
                      Assets.assets_svg_ic_view_transaction_svg,
                      color: context.appColors.textColor1,
                      width: 16,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget buildKeyValue({
    required String key,
    required String value,
    TextStyle? valueStyle,
  }) =>
      buildRow(
          key: key,
          value: Text(
            value,
            style: valueStyle,
          ));

  Widget buildRow({
    required String key,
    required Widget value,
    TextStyle? valueStyle,
  }) {
    return Builder(
      builder: (context) => Row(
        children: [
          Expanded(
            child: Text(
              key,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 18 / 14,
                color: context.appColors.textColor2,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: DefaultTextStyle(
                style: DefaultTextStyle.of(context)
                    .style
                    .copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 18 / 14,
                      color: context.appColors.textColor1,
                    )
                    .merge(valueStyle),
                child: value,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(List<Widget> children) {
    return Builder(
      builder: (context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 1,
            color: context.appColors.dividerColor,
          ),
        ),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: children.length,
          primary: false,
          padding: EdgeInsets.zero,
          itemBuilder: (c, index) => children[index],
          separatorBuilder: (c, index) => const SizedBox(height: 16),
        ),
      ),
    );
  }
}
