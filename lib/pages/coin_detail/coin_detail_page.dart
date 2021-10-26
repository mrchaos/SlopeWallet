import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/coin_detail/coin_detail_model.dart';
import 'package:wallet/pages/coin_detail/record_type.dart';
import 'package:wallet/pages/coin_detail/tx_record.dart';
import 'package:wallet/pages/home/view/wallet_bottom_sheet.dart';
import 'package:wallet/pages/home/wallet_main_page.dart';
import 'package:wallet/slope_widget/tab_bar.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/coin_image.dart';
import 'package:wallet/widgets/currency_format.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wallet/widgets/placeholder/no_data_place_holder.dart';

import '../home/model/market_price_view_model.dart';
import 'tx_instruction_ext.dart';

class CoinDetailPage extends StatelessWidget {
  final WalletEntity walletEntity;
  final CoinEntity coinEntity;

  CoinDetailPage({Key? key, required this.walletEntity, required this.coinEntity})
      : super(key: key);

  Widget coinAssetHead() {
    return Builder(builder: (context) {
      return Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 32),
        padding: const EdgeInsets.all(20),
        height: 200,
        decoration: BoxDecoration(
          color: AppTheme.of(context).currentColors.dividerColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 18,
              child: Text(
                'Total Asset',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400, color: appColors.textColor1),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 32,
              child: DefaultTextStyle(
                style: DefaultTextStyle.of(context).style.copyWith(
                    fontSize: 28, fontWeight: FontWeight.w700, color: appColors.textColor1),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        context.select((CoinDetailModel vm) =>
                            CurrencyFormat.formatDecimal(coinEntity.balance)),
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700, color: appColors.textColor1),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 18,
              child: Row(
                children: [
                  Selector2<CoinDetailModel, MarketPriceViewModel, String>(
                    selector: (c, vm1, vm2) {
                      coinEntity.usdtPrice =
                          vm2.getMarketPrice(coinEntity.coin, defaultValue: coinEntity.usdtPrice);
                      return CurrencyFormat.formatUSDT(coinEntity.usdtBalance);
                    },
                    builder: (c, coinUsdt, _) => Text(
                      '≈ $coinUsdt USDT',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400, color: appColors.textColor1),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF292C33),
                              borderRadius: BorderRadius.all(Radius.circular(4))),
                          child: service.svg.asset(Assets.assets_svg_wallet_deposit_svg,
                              width: 20, height: 20, fit: BoxFit.cover, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Send',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                context.isLightTheme ? Colors.white : context.appColors.textColor4,
                          ),
                        ),
                        const SizedBox(width: 28),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(appColors.textColor1),
                      padding: MaterialStateProperty.all(EdgeInsets.only(top: 12, bottom: 12)),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                      fixedSize: MaterialStateProperty.all(Size.fromHeight(44)),
                    ),
                    onPressed: () {
                      if (!checkSolBalance(context)) {
                        return;
                      }
                      service.router
                          .pushNamed(RouteName.walletPayPage, arguments: {'coin': coinEntity});
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextButton(
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF292C33),
                              borderRadius: BorderRadius.all(Radius.circular(4))),
                          child: service.svg.asset(Assets.assets_svg_wallet_withdraw_svg,
                              width: 20, height: 20, fit: BoxFit.scaleDown, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Receive',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color:
                                context.isLightTheme ? Colors.white : context.appColors.textColor4,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(appColors.textColor1),
                      padding: MaterialStateProperty.all(EdgeInsets.only(top: 12, bottom: 12)),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                      fixedSize: MaterialStateProperty.all(Size.fromHeight(44)),
                    ),
                    onPressed: () {
                      ShareWalletQrcodeModal.showView(
                          context: context,
                          address: walletEntity.address,
                          coinName: coinEntity.coin,
                          coinIcon: coinEntity.icon,
                          copyCallback: (String address) {
                            Clipboard.setData(ClipboardData(text: walletEntity.address));
                            showToast('Copy success!');
                          });
                    },
                  ),
                )
              ],
            )
          ],
        ),
      );
    });
  }

  Widget buildRecord(MyConfirmedTransactionWithTXID transaction) {
    if (transaction.isTxSuccess) {
      return TxRecord(transaction: transaction, token: coinEntity, txInstruction: null);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var tx in transaction.instructions)
          TxRecord(
            transaction: transaction,
            token: coinEntity,
            txInstruction: tx,
          ),
      ],
    );
  }

  late AppColors appColors;
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  void _onRefresh(CoinDetailModel viewModel) async {
    Future.wait([
      viewModel.getBalance(),
      viewModel.refreshTransactions(),
    ]).whenComplete(() => _refreshController.refreshCompleted(resetFooterState: true));
  }

  ValueNotifier<bool> _loadingNotifier = ValueNotifier(false);

  void _onLoading(CoinDetailModel viewModel) {
    viewModel.loadMoreTransactions().then((more) {
      _loadingNotifier.value = false;
      // _refreshController.loadComplete();
      if (!more) {
        //   _refreshController.loadNoData();
      }
    });
  }

  @override
  Widget build(BuildContext? context) {
    appColors = context!.read<AppTheme>().currentColors;
    return ScaffoldMessenger(
      child: ChangeNotifierProvider(
        create: (c) => CoinDetailModel(walletEntity, coinEntity),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: WalletBar(
              showBackButton: true,
              title: Row(
                children: [
                  CoinImage(
                    icon: coinEntity.icon,
                    radius: 14,
                  ),
                  const SizedBox(width: 8),
                  Text(coinEntity.coin),
                ],
              ),
            ),
            body: Selector<CoinDetailModel, List<MyConfirmedTransactionWithTXID>>(
              selector: (c, vm) => vm.showTransactionList,
              builder: (context, list, _) => SmartRefresher(
                // enablePullUp: true,
                controller: _refreshController,
                onRefresh: () => _onRefresh(context.read<CoinDetailModel>()),
                // onLoading: () => _onLoading(context.read<CoinDetailModel>()),
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    SliverToBoxAdapter(child: coinAssetHead()),
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      centerTitle: false,
                      toolbarHeight: 24 + 16,
                      floating: true,
                      pinned: true,
                      title: SlopeTabBar(
                        height: 24 + 16,
                        labels: ['Asset Record'],
                        actions: [
                          Visibility(
                            visible: false,
                            child: TextButton(
                              onPressed: () async {
                                final type = await showRecordTypePicker(context);
                                final vm = context.read<CoinDetailModel>();
                                if (type != null) {
                                  vm.recordType = type;
                                }
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: context.isLightTheme
                                    ? appColors.lightGray
                                    : appColors.darkLightGray,
                                shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
                                padding:
                                    const EdgeInsets.only(left: 14, right: 8, top: 6, bottom: 6),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    context.select((CoinDetailModel vm) => vm.recordType).text,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: appColors.textColor1,
                                    ),
                                  ),
                                  service.svg.asset(
                                    Assets.assets_svg_rank_tags_svg,
                                    color: appColors.textColor1,
                                    width: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverSafeArea(
                      top: false,
                      sliver: SliverToBoxAdapter(
                        child: list.isEmpty
                            ? emptyRecord
                            : Container(
                                margin: const EdgeInsets.only(left: 24, right: 24, bottom: 20),
                                padding: const EdgeInsets.only(top: 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (var transaction in list) buildRecord(transaction),
                                    // Visibility(
                                    //   visible: context.read<CoinDetailModel>().hasMoreTransaction&&false,
                                    //   child: Divider(
                                    //     height: 1,
                                    //     thickness: 1,
                                    //     indent: 40,
                                    //     endIndent: 20,
                                    //     color: appColors.dividerColor,
                                    //   ),
                                    // ),
                                    ValueListenableBuilder<bool>(
                                      valueListenable: _loadingNotifier,
                                      child: Container(
                                        child: const CupertinoActivityIndicator(),
                                        height: 60,
                                      ),
                                      builder: (c, value, child) {
                                        return Visibility(
                                          child: child!,
                                          visible: value,
                                        );
                                      },
                                    ),
                                    ValueListenableBuilder<bool>(
                                      valueListenable: _loadingNotifier,
                                      child: Container(
                                        height: 60,
                                        child: TextButton(
                                          child: Text(
                                            'More',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: appColors.textColor1),
                                          ),
                                          onPressed: () {
                                            _loadingNotifier.value = true;
                                            _onLoading(context.read<CoinDetailModel>());
                                          },
                                        ),
                                      ),
                                      builder: (context, loading, child) => Visibility(
                                        visible: !loading &&
                                            context.select(
                                                (CoinDetailModel vm) => vm.hasMoreTransaction),
                                        child: child!,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget get emptyRecord {
    return NoDataPlaceHolder(
      margin: const EdgeInsets.symmetric(vertical: 24),
    );
  }
}
