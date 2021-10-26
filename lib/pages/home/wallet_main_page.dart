import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/module/wallet_module.dart';
import 'package:wallet/pages/home/model/nft_list_model.dart';
import 'package:wallet/pages/home/model/wallet_ext.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/pages/home/nft_list_page.dart';
import 'package:wallet/pages/home/token_list_page.dart';
import 'package:wallet/pages/home/view/wallet_bottom_sheet.dart';
import 'package:wallet/pages/navigation_page.dart';
import 'package:wallet/slope_widget/tab_bar.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/utils/solana_tokens.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/Dialog/public_dialog.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/currency_format.dart';
import 'package:wallet/widgets/loading/loading_util.dart';

class WalletMainPage extends StatefulWidget {
  const WalletMainPage({Key? key}) : super(key: key);

  @override
  _WalletMainPageState createState() => _WalletMainPageState();
}

class _WalletMainPageState extends State<WalletMainPage> with TickerProviderStateMixin, RouteAware {
  final _pageIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      WalletMainModel.instance.queryAllWallets();

      ///Solana
      Future.delayed(const Duration(microseconds: 1500), () {
        SolanaTokenApi().request().listen((event) {
          debugPrint('solana--> ${event.toString()}');
        });
      });
    });

    _tabController =
        TabController(length: _tabPages.length, initialIndex: _pageIndexNotifier.value, vsync: this)
          ..addListener(() {
            hideLoading();
            _pageIndexNotifier.value = _tabController.index;
            searchNFTNotifier.value = false;
            if (_pageIndexNotifier.value != 1) {
              _animateTo(0);
            }
          });
    searchNFTNotifier.addListener(_onSearchStatusChange);
  }

  void _onSearchStatusChange() {
    if (searchNFTNotifier.value != true) {
      FocusManager.instance.primaryFocus?.unfocus();
      _animateTo(0);
    }
  }

  void _animateTo(double offset) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    service.router.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPushNext() {
    //，LoadingSnackBar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    hideLoading();
    super.didPushNext();
  }

  @override
  void dispose() {
    service.router.unsubscribe(this);
    searchNFTNotifier.removeListener(_onSearchStatusChange);

    super.dispose();
  }

  Map<String, Widget> _tabPages = {
    'Token': TokenListPage(),
    'Collection': NftListPage(),
  };

  Widget _buildTabBar(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _pageIndexNotifier,
      builder: (c, pageIndex, child) => SlopeTabBar(
        labels: _tabPages.keys.toList(growable: false),
        initialIndex: pageIndex,
        controller: _tabController,
        actions: [
          GestureDetector(
            onTap: () {
              _animateTo(16 + 174 + 24);
              if (_tabController.index == 0) {
                service.router.pushNamed(RouteName.CreateCoinPage);
              } else {
                searchNFTNotifier.value = true;
              }
            },
            child: Container(
              height: 24,
              child: IndexedStack(
                index: pageIndex,
                alignment: Alignment.centerRight,
                children: [
                  service.svg.asset(Assets.assets_svg_coin_add_svg,
                      color: AppTheme.of(context).currentColors.textColor1),
                  ValueListenableBuilder<bool>(
                    valueListenable: searchNFTNotifier,
                    child: service.svg.asset(
                      Assets.assets_svg_search_svg,
                      color: AppTheme.of(context).currentColors.textColor1,
                    ),
                    builder: (c, isSearch, child) => ValueListenableBuilder<int>(
                      valueListenable: nftListSizeNotifier,
                      builder: (c, nftSize, _) => Visibility(
                        visible: !isSearch && nftSize > 0,
                        child: child!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  late TabController _tabController;
  final _scrollController = ScrollController();

  Widget _bodyUI(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _pageIndexNotifier,
      builder: (context, pageIndex, child) {
        //pinned sliver header issue
        //see https://github.com/flutter/flutter/issues/22393
        const double topSliverHeight = 16 + 174 + 24;
        return ExtendedNestedScrollView(
          controller: _scrollController,
          onlyOneScrollInBody: true,
          physics: _pageIndexNotifier.value == 0 ? const NeverScrollableScrollPhysics() : null,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                pinned: _pageIndexNotifier.value == 0,
                delegate: StickyHeaderDelegate(
                  child: PreferredSize(
                    preferredSize: Size.fromHeight(topSliverHeight),
                    child: _buildHeader(context),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyHeaderDelegate(
                  child: PreferredSize(
                    preferredSize: Size.fromHeight(kSlopeTabBarHeight),
                    child: _buildTabBar(context),
                  ),
                ),
              ),
            ];
          },
          pinnedHeaderSliverHeightBuilder: () {
            if (_pageIndexNotifier.value == 0) {
              return kSlopeTabBarHeight + topSliverHeight;
            }
            return kSlopeTabBarHeight;
          },
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverFillRemaining(
                child: TabBarView(
                  children: [..._tabPages.values],
                  controller: _tabController,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (context.select((WalletMainModel vm) => vm.currentWallet == null)) return const SizedBox();
    return Scaffold(
      backgroundColor: AppTheme.of(context).currentColors.backgroundColor,
      appBar: _buildAppBar(),
      body: _bodyUI(context),
    );
  }

  void _checkPhotoPermission({
    BuildContext? context,
    ImageSource? source,
    VoidCallback? onGranted,
  }) async {
    PermissionStatus status;
    Permission permission;
    if (source == ImageSource.camera) {
      //
      permission = Permission.camera;
    } else {
      //
      permission = Permission.photos;
    }

    status = await permission.status;

    if (status.isDenied) {
      //
      permission.request().isGranted.then((value) {
        if (value) {
          // getImage(context, source);
          onGranted?.call();
        }
      });

      return;
    }

    if (status.isPermanentlyDenied) {
      // Android：，
      _showPhotoPermissionDialog(context!, source);
      return;
    }

    if (status.isRestricted || status.isDenied || status.isLimited) {
      // iOS:
      _showPhotoPermissionDialog(context!, source);

      return;
    }
    if (await permission.shouldShowRequestRationale) {
      // Android:
      _showPhotoPermissionDialog(context!, source);

      return;
    }
    //
    var result = await permission.request();
    if (result.isGranted) {
      //
      // getImage(context, source);
      onGranted?.call();
    }
  }

  _showPhotoPermissionDialog(BuildContext context, ImageSource? source) {
    var title =
        'Allow access your album in ”Settings”->”Privacy”->”${source == ImageSource.camera ? 'Camera' : 'Photos'}”';
    var cancelButtonLabel = 'OK';
    var confirmButtonLabel = 'Go to Setting';
    var confirmPressed = () {
      //
      var isOpen = openAppSettings();
      //dismiss dialog
      Navigator.pop(context);
    };

    showAlertHorizontalButtonDialog(
      context: context,
      title: title,
      cancelButtonLabel: cancelButtonLabel,
      confirmButtonLabel: confirmButtonLabel,
      confirmPressed: confirmPressed,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return WalletBar(
      showBackButton: true,
      leadingWidth: 24,
      toolbarHeight: config.app.appType == WalletAppType.slope ? 60 : kToolbarHeight,
      leading: Builder(
        builder: (context) {
          return IconButton(
            padding: EdgeInsets.zero,
            icon: service.svg.asset(Assets.assets_svg_wallet_screen_svg,
                fit: BoxFit.none, color: AppTheme.of(context).currentColors.textColor1),
            onPressed: () {
              if (config.app.appType == WalletAppType.slope) {
                if (null != WalletModule.slopeOpenDrawer) WalletModule.slopeOpenDrawer!();
              } else {
                drawerStateKey.currentState?.openDrawer();
              }
            },
          );
        },
      ),
      title: Builder(
        builder: (context) {
          WalletEntity? bean = context.watch<WalletMainModel>().currentWallet;
          return Text(
            bean?.walletName.notBreak ?? '',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppTheme.of(context).currentColors.textColor1),
          );
        },
      ),
      actions: [
        Builder(builder: (context) {
          return Visibility(
            visible: !kIsWeb,
            child: GestureDetector(
              onTap: () {
                if (null == WalletMainModel.instance.currentWallet) return;
                if (0 == WalletMainModel.instance.currentWallet!.coins.length) {
                  showAlertVerticalButtonDialog(
                      context: context,
                      showSubButton: false,
                      barrierColor: Colors.black.withOpacity(0.4),
                      barrierDismissible: false,
                      mainButtonPressed: () {
                        Navigator.of(context).pop();
                        service.router.pushNamed(RouteName.CreateCoinPage);
                      },
                      mainButtonLabel: "Add",
                      title: "Add token",
                      content: "You need add token to do the transaction.");
                  return;
                } else if (!checkSolBalance(context)) {
                  return;
                }

                _checkPhotoPermission(
                    context: context,
                    source: ImageSource.camera,
                    onGranted: () {
                      //
                      service.router.pushNamed(RouteName.walletScanPage).then((value) {
                        if (null != value) {
                          service.router
                              .pushNamed(RouteName.walletPayPage, arguments: {'url': value});
                        }
                      });
                    });
              },
              child: service.svg.asset(Assets.assets_svg_nav_scan_svg,
                  width: 28,
                  height: 28,
                  fit: BoxFit.scaleDown,
                  color: AppTheme.of(context).currentColors.textColor1),
            ),
          );
        }),
        config.app.appType == WalletAppType.slope
            ? SizedBox(
                width: 16,
              )
            : SizedBox(),
        config.app.appType == WalletAppType.slope
            ? GestureDetector(
                onTap: () {
                  service.router.pushNamed(RouteName.myProfilePage);
                },
                child: service.svg.asset(
                  Assets.assets_svg_slope_setting_svg,
                  width: 28,
                  height: 28,
                  fit: BoxFit.scaleDown,
                  color: AppTheme.of(context).currentColors.textColor1,
                ),
              )
            : SizedBox(),
        const SizedBox(
          width: 24,
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Builder(builder: (context) {
      if (null == context.watch<WalletMainModel>().currentWallet) return Container();
      WalletEntity bean =
          context.select<WalletMainModel, WalletEntity>((value) => value.currentWallet!);
      var totalUsdtBalance =
          context.select<WalletMainModel, Decimal>((value) => value.currentWallet.totalUsdtBalance);
      return Container(
        margin: const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 24),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        // height: 174,
        decoration: BoxDecoration(
          color: AppTheme.of(context).currentColors.greenAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24,
              child: Row(
                children: [
                  Text(
                    'Total Asset (≈USDT)',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.of(context).currentColors.blackTextInGreenAccent),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: bean.address));
                      showToast('Copy success!');
                    },
                    child: Container(
                      height: 24,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppTheme.of(context).lightColors.textColor1, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            bean.address.ellAddress(4, 4),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.of(context).currentColors.blackTextInGreenAccent),
                          ),
                          const SizedBox(width: 3),
                          service.svg.asset(Assets.assets_svg_wallet_copy_svg),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 28,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  CurrencyFormat.formatUSDT(totalUsdtBalance, maxDecimalDigits: 2),
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.of(context).currentColors.blackTextInGreenAccent),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFFFF),
                              borderRadius: BorderRadius.all(Radius.circular(4))),
                          child: service.svg.asset(
                            Assets.assets_svg_wallet_deposit_svg,
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          'Send',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: context.appColors.blackTextInGreenAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      fixedSize: Size.fromHeight(44),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      if (0 == bean.coins.length) {
                        showAlertVerticalButtonDialog(
                            context: context,
                            showSubButton: false,
                            barrierColor: Colors.black.withOpacity(0.4),
                            barrierDismissible: false,
                            mainButtonPressed: () {
                              Navigator.of(context).pop();
                              service.router.pushNamed(RouteName.CreateCoinPage);
                            },
                            mainButtonLabel: "Add",
                            title: "Add token",
                            content: "You need add token to do the transaction.");
                        return;
                      } else {
                        if (!checkSolBalance(context)) {
                          return;
                        }
                      }

                      service.router.pushNamed(RouteName.walletPayPage);
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFFFFF),
                                borderRadius: BorderRadius.all(Radius.circular(4))),
                            child: service.svg.asset(
                              Assets.assets_svg_wallet_withdraw_svg,
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(width: 14),
                        Text(
                          'Receive',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ],
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: context.appColors.blackTextInGreenAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      fixedSize: Size.fromHeight(44),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () {
                      if (0 == bean.coins.length) {
                        showAlertVerticalButtonDialog(
                            context: context,
                            showSubButton: false,
                            barrierColor: Colors.black.withOpacity(0.4),
                            barrierDismissible: false,
                            mainButtonPressed: () {
                              Navigator.of(context).pop();
                              service.router.pushNamed(RouteName.CreateCoinPage);
                            },
                            mainButtonLabel: "Add",
                            title: "Add token",
                            content: "You need add token to do the transaction.");
                        return;
                      }
                      ShareWalletQrcodeModal.showView(
                          context: context,
                          address: bean.address,
                          coinName: bean.coins.first.coin,
                          coinIcon: bean.coins.first.icon,
                          copyCallback: (String address) {
                            Clipboard.setData(ClipboardData(text: bean.address));
                            showToast('Copy success!');
                          });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

/// SOL：
///
/// “Send”、，，5s, Receive
bool checkSolBalance(BuildContext context) {
  var wallet = context.read<WalletMainModel>().currentWallet;
  final solCoin = wallet?.coins.firstWhereOrNull((elem) => elem.isSOL);
  if (null != solCoin && solCoin.counts <= 0) {
    final appTheme = context.read<AppTheme>();
    var snackBar = SnackBar(
      content: Text(
        'You need to deposit SOL in order to pay for transactions',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          height: 18 / 14,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16, left: 24, right: 24),
      padding: EdgeInsets.only(left: 16, right: 6),
      duration: const Duration(seconds: 5),
      elevation: 0,
      backgroundColor:
          context.isLightTheme ? appTheme.lightColors.textColor1 : appTheme.darkColors.textColor4,
      behavior: SnackBarBehavior.floating,
      action: MySnackBarAction(
        label: 'Receive',
        textColor: Colors.white,
        buttonStyle: TextButton.styleFrom(
          textStyle: const TextStyle(decoration: TextDecoration.underline),
        ),
        onPressed: () {
          ShareWalletQrcodeModal.showView(
              context: context,
              address: wallet!.address,
              coinName: solCoin.coin,
              coinIcon: solCoin.icon,
              copyCallback: (String address) {
                Clipboard.setData(ClipboardData(text: wallet.address));
                showToast('Copy success!');
              });
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return false;
  }

  return true;
}

class MySnackBarAction extends SnackBarAction {
  final ButtonStyle? buttonStyle;

  MySnackBarAction({
    Key? key,
    Color? textColor,
    Color? disabledTextColor,
    this.buttonStyle,
    required String label,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          textColor: textColor,
          disabledTextColor: disabledTextColor,
          label: label,
          onPressed: onPressed,
        );

  @override
  State<MySnackBarAction> createState() => _SnackBarActionState();
}

class _SnackBarActionState extends State<MySnackBarAction> {
  bool _haveTriggeredAction = false;

  void _handlePressed() {
    if (_haveTriggeredAction) return;
    setState(() {
      _haveTriggeredAction = true;
    });
    widget.onPressed();
    ScaffoldMessenger.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.action);
  }

  @override
  Widget build(BuildContext context) {
    Color? resolveForegroundColor(Set<MaterialState> states) {
      final SnackBarThemeData snackBarTheme = Theme.of(context).snackBarTheme;
      if (states.contains(MaterialState.disabled))
        return widget.disabledTextColor ?? snackBarTheme.disabledActionTextColor;
      return widget.textColor ?? snackBarTheme.actionTextColor;
    }

    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(resolveForegroundColor),
      ).merge(widget.buttonStyle),
      onPressed: _haveTriggeredAction ? null : _handlePressed,
      child: Text(widget.label),
    );
  }
}
