import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/pages/home/view/asset_detail_item.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/currency_format.dart';

import 'model/market_price_view_model.dart';

///Token
class TokenListPage extends StatefulWidget {
  const TokenListPage({Key? key}) : super(key: key);

  @override
  _TokenListPageState createState() => _TokenListPageState();
}

class _TokenListPageState extends State<TokenListPage> with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  void _onRefresh(WalletMainModel viewModel) async {
    try {
      //
      await viewModel.getCurrentWalletTokenList().timeout(const Duration(seconds: 30));
    } finally {
      _refreshController.refreshCompleted(resetFooterState: true);
    }
  }

  @override
  bool get wantKeepAlive => true;
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Builder(
        builder: (context) {
          WalletMainModel _mainModel = context.watch<WalletMainModel>();
          WalletEntity? wallet =
              context.select<WalletMainModel, WalletEntity?>((value) => value.currentWallet);
          // CoinEntity? coins = wallet!.coins.firstWhereOrNull((element) => element.contractAddress == "7RizW7KJWR7zi13CwMSuTKkvVDLoS9EJyyUshokHJ9tL");

          // CoinEntity? coins2 = wallet!.coins.firstWhereOrNull((element) => element.contractAddress == "7RizW7KJWR7zi13CwMSuTKkvVDLoS9EJyyUshokHJ9tL");
          // logger.d('coins:${coins}');
          // logger.d('coins:${coins!.coin}');
          // logger.d('coins:${coins!.coin}');
          // logger.d('coins2:${coins2}');
          // logger.d('coins2:${coins2!.coin}');
          // logger.d('coins2:${coins2!.coin}');
          // var wallet=_mainModel.currentWallet;
          if (null == wallet) return SizedBox();
          var showCoinList = wallet.coins.where((coin) => !coin.hide).toList();
          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            child: SmartRefresher(
              enablePullUp: false,
              enablePullDown: true,
              controller: _refreshController,
              onRefresh: () => _onRefresh(context.read<WalletMainModel>()),
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      CoinEntity bean = showCoinList[index];
                      return Builder(builder: (context) {
                        var price = context.select((MarketPriceViewModel vm) =>
                            vm.getMarketPrice(bean.coin, defaultValue: bean.usdtPrice));
                        bean.usdtPrice = price;
                        return AssetDetailItem(
                          icon: bean.icon,
                          name: bean.coin,
                          isLast: index >= showCoinList.length - 1,
                          balance: CurrencyFormat.formatDecimal(bean.balance),
                          usdtBalance: CurrencyFormat.formatUSDT(bean.usdtBalance),
                          onTap: () {
                            service.router.pushNamed(
                              RouteName.coinDetail,
                              arguments: {'wallet': _mainModel.currentWallet, 'coin': bean},
                            );
                          },
                        );
                      });
                    }, childCount: showCoinList.length),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
