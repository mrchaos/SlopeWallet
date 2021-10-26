import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/home/create_coin_page/widget/create_coin_model.dart';
import 'package:wallet/pages/home/create_coin_page/widget/create_coin_list.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/slope_widget/tab_bar.dart';
import 'package:wallet/slope_widget/text_field.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/button/app_back_button.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wd_common_package/wd_common_package.dart';

class CreateCoinPage extends StatefulWidget {
  @override
  _CreateCoinPageState createState() => _CreateCoinPageState();
}

class _CreateCoinPageState extends State<CreateCoinPage> with RouteAware, TickerProviderStateMixin {
  final _searchKeyNotifier = ValueNotifier<String>('');

  Map<String, Widget> get _tabValues =>
      {
        'Hot': ValueListenableBuilder<String>(
          valueListenable: _searchKeyNotifier,
          builder: (c, searchKey, _) =>
              CreateCoinWidget(
                //hot token
                contractList: contractList,
                searchKey: searchKey,
                type: 0,
              ),
        ),
        'Manual': ValueListenableBuilder<String>(
          valueListenable: _searchKeyNotifier,
          builder: (c, searchKey, _) =>
              CreateCoinWidget(
                //custom token
                contractList: _customCoin,
                searchKey: searchKey,
                type: 1,
              ),
        ),
      };

  final _isShowCustomCoinIconNotifier = ValueNotifier<bool>(false);

  late WalletEntity wallet;

  @override
  void initState() {
    _createCoinModel = CreateCoinModel();
    super.initState();
    contractList = WalletMainModel.instance.loadContractCache();
    contractList.removeWhere((token) => token.isSOL);

    wallet = WalletMainModel.instance.currentWallet!;
    _tabController = TabController(length: _tabValues.length, initialIndex: 0, vsync: this);
    _customCoin = _createCoinModel.getCacheCustomCoin(walletAddress: wallet.address).reversed.toList();
    //
    _searchKeyNotifier.notifyListeners();
    _tabController.addListener(_onTabPageChange);

    /// ;
    _getContractList();
  }

  void _onTabPageChange() {
    _isShowCustomCoinIconNotifier.value = _tabController.index == 1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    service.router.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    service.router.unsubscribe(this);
    _isShowCustomCoinIconNotifier.dispose();
    _tabController.removeListener(_onTabPageChange);
    _searchKeyNotifier.dispose();
    _tokenListNotifier.dispose();
    super.dispose();
  }

  @override
  void didPop() {
    hideLoading();
    super.didPop();
  }

  @override
  void didPushNext() {
    hideLoading();
    super.didPushNext();
  }

  List<CoinEntity> contractList = [];
  List<CoinEntity> _customCoin = [];

  late CreateCoinModel _createCoinModel;

  final _tokenListNotifier = ValueNotifier<List<CoinEntity>>([]);

  void _getContractList() async {
    var result = await WalletMainModel.instance.getContractList();
    _tokenListNotifier.value = result;
  }

  late TabController _tabController;

  double heightOfRow = 72;

  PreferredSizeWidget _buildAppBar(AppColors _appColors) {
    return WalletBar(
      showBackButton: true,
      leadingWidth: 28,
      leading: AppBackButton(),
      title: SlopeSearchTextField(
        hintText: 'Search for token',
        margin: const EdgeInsets.only(right: 16),
        onChanged: (text) {
          _searchKeyNotifier.value = text;
        },
      ),
    );
  }

// // token
// Future<String> requestToken(CoinEntity model, bool isCreated) async {
//   if (null == WalletMainModel.instance.currentWallet) return "";
//   WalletEntity _walletModel = WalletMainModel.instance.currentWallet!;
//   String privateKey =
//       WalletEncrypt.aesDecrypt(_walletModel.privateKey, walletManager.aesKey);
//   // model.contractAddress = 'Df44Qh5TPMLuW527dMtxPb9Ho4kgWxP4mKNGSm21AoDj';
//   var temp = await walletManager.createToken(
//       privateKey, model.contractAddress, _walletModel.address);
//   return temp;
// }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final _appColors = context
          .read<AppTheme>()
          .currentColors;

      return Scaffold(
        appBar: _buildAppBar(_appColors),
        backgroundColor: AppTheme
            .of(context)
            .currentColors
            .backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Builder(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlopeTabBar(
                controller: _tabController,
                initialIndex: 0,
                margin: const EdgeInsets.only(top: 8),
                labels: _tabValues.keys.toList(growable: false),
                actions: [
                  ValueListenableBuilder<bool>(
                      valueListenable: _isShowCustomCoinIconNotifier,
                      builder: (c, value, v) {
                        return Visibility(
                            visible: value,
                            child: GestureDetector(
                              onTap: () =>
                                  service.router
                                      .pushNamed(RouteName.addManualTokenPage)
                                      .then((value) {
                                    _searchKeyNotifier.value = '';
                                    List<CoinEntity> _getCustomCoin = _createCoinModel
                                        .getCacheCustomCoin(walletAddress: wallet.address);
                                    // logger.d('_customCoin:${_customCoin.first.decimals}');
                                    if (_customCoin.length != _getCustomCoin.length) {
                                      setState(() {
                                        _customCoin = _getCustomCoin.reversed.toList();
                                  });
                                    }
                                    // if (_customCoin.length == coinList.length) {
                                    //   _getCustomCoin();
                                    // }
                                  }),
                              child: service.svg.asset(
                                Assets.assets_svg_coin_add_svg,
                                color: AppTheme
                                    .of(context)
                                    .currentColors
                                    .textColor1,
                              ),
                            ));
                      }),
                ],
                onTap: (index) => _onTabPageChange(),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [..._tabValues.values],
                ),
              )
            ],
          );
        }),
      );
    });
  }
