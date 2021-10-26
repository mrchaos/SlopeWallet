import 'dart:ui';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/pages/home/view/wallet_vertical_menu.dart';
import 'package:wallet/pages/profile/view/create_wallet_sheet.dart';
import 'package:wallet/pages/profile/view/wallet_list_item.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/button/app_back_button.dart';
import 'package:wallet/widgets/currency_format.dart';
import 'package:wallet/widgets/loading/loading_util.dart';

class WalletListPage extends StatefulWidget {
  const WalletListPage({Key? key}) : super(key: key);

  @override
  _WalletListPageState createState() => _WalletListPageState();
}

class _WalletListPageState extends State<WalletListPage> {
  List<WalletEntity> _wallets = [];
  bool _isEditing = false;
  int _currentMenuIdx = 0;

  void _initData(BuildContext context) {
    List<String> supportChains = context.read<WalletMainModel>().supportedBlockChains;
    _wallets =
        context.watch<WalletMainModel>().getWalletsByBlockChain(supportChains[_currentMenuIdx]);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _isEditing = widget.isEditing;
  // }
  @override
  Widget build(BuildContext context) {
    _initData(context);
    return Scaffold(
      backgroundColor: AppTheme.of(context).currentColors.backgroundColor,
      appBar: WalletBar(
        showBackButton: true,
        leading: AppBackButton(),
        title: Text(
          "Wallet",
          style: TextStyle(
              color: AppTheme.of(context).currentColors.textColor1,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: Container(
                height: 44,
                // color: Colors.red,
                padding: EdgeInsets.only(right: 9),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isEditing = !_isEditing;
                      });
                    },
                    child: Center(
                      child: Text(
                        _isEditing ? "Done" : "Edit",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.of(context).currentColors.textColor1),
                      ),
                    )),
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 15, right: 24),
                child: Row(
                  children: [
                    WalletVerticalMenu(
                        isFromDrawer: false,
                        trackSize: Size(4, 36),
                        iconSize: 36,
                        svgIcons: [...context.read<WalletMainModel>().blockChainsNormalIcon],
                        selectedSvgIcons: [
                          ...context.read<WalletMainModel>().blockChainsSelectedIcon
                        ],
                        onSelectItem: (index) {
                          if (_currentMenuIdx == index) return;
                          setState(() {
                            _currentMenuIdx = index;
                          });
                        }),
                    const SizedBox(width: 20),
                    Expanded(
                        child: ListView.separated(
                            itemCount: _wallets.length,
                            separatorBuilder: (context, idx) => SizedBox(height: 16),
                            itemBuilder: (context, idx) {
                              return WalletListItem(
                                  onDelete: () {
                                    _showWarning(_wallets[idx]);
                                  },
                                  onTap: () {
                                    service.router.pushNamed(RouteName.walletDetail,
                                        arguments: _wallets[idx]);
                                  },
                                  isEditing: _isEditing,
                                  cardBg: _wallets[idx].walletCardBg,
                                  walletName: _wallets[idx].walletName,
                                  address: _wallets[idx].address.ellAddress());
                              // return WalletListItem();
                            })),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !_isEditing,
              child: Container(
                height: 88,
                padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
                // color: Colors.red,
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      service.svg.asset(
                        Assets.assets_svg_wallet_add_svg,
                        width: 20,
                        height: 20,
                        fit: BoxFit.scaleDown,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                          'Add ${context.read<WalletMainModel>().supportedBlockChains[_currentMenuIdx]} Wallet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppTheme.of(context).currentColors.purpleAccent),
                    padding: MaterialStateProperty.all(EdgeInsets.only(top: 12, bottom: 12)),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
                  ),
                  onPressed: () {
                    // WalletCreateModel.instance.isFromDrawer = false;
                    showCreateWalletSheet(context,
                        context.read<WalletMainModel>().supportedBlockChains[_currentMenuIdx]);
                    // service.router.pushNamed(RouteName.walletImport);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Decimal _usdtBalance = Decimal.zero;
  bool _isShow = false;
  bool _isBalanceLoad = false;
  String _willDeleteWalletId = "";

  void _showWarning(WalletEntity entity) async {
    _isShow = true;
    _willDeleteWalletId = entity.walletId;
    _usdtBalance = entity.totalUsdtBalance;
    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, _setState) {
              _getBalance(entity, _setState);
              return Container(
                decoration: BoxDecoration(
                    color: AppTheme.of(context).currentColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                child: ListView(
                  padding: EdgeInsets.only(
                      top: 20,
                      bottom: MediaQueryData.fromWindow(window).padding.bottom + 20,
                      left: 20,
                      right: 20),
                  shrinkWrap: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        service.image.asset(Assets.assets_image_wallet_yellow_warning_png),
                        SizedBox(width: 6.5),
                        Text(
                          "Warning",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppTheme.of(context).currentColors.textColor1,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 22 / 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 48),
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      height: 94,
                      decoration: BoxDecoration(
                        color: entity.walletBgColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entity.walletName.notBreak,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: AppTheme.of(context).currentColors.blackTextInGreenAccent,
                                fontSize: 14),
                          ),
                          Text(
                            "${CurrencyFormat.formatUSDT(_usdtBalance, maxDecimalDigits: 2)} USDT",
                            style: TextStyle(
                                color: AppTheme.of(context).currentColors.blackTextInGreenAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Make sure you backup your Mnemonic words.Savings in the wallet will not be used.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppTheme.of(context).currentColors.textColor2, fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppTheme.of(context).themeMode == ThemeMode.light
                                        ? AppTheme.of(context).currentColors.textColor3
                                        : AppTheme.of(context).currentColors.textColor1,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    height: 20 / 16),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppTheme.of(context).themeMode == ThemeMode.light
                                        ? Color(0xFFF7F8FA)
                                        : AppTheme.of(context).currentColors.dividerColor),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            height: 48,
                            child: TextButton(
                              onPressed: () {
                                service.router
                                    .pushNamed(RouteName.walletPasswordPage,
                                        arguments: WalletCreateRelatedData(isDeleteWallet: true))
                                    .then((value) {
                                  if (value == null) {
                                    return;
                                  }
                                  if (value is bool && value) {
                                    Navigator.pop(context);
                                    context.read<WalletMainModel>().deleteWallet(entity);
                                  } else {
                                    showToast('Password Error');
                                  }
                                });
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                  color: AppTheme.of(context).currentColors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 20 / 16,
                                ),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color: AppTheme.of(context).currentColors.red, width: 1))),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        });
    _usdtBalance = Decimal.zero;
    _isShow = false;
    _isBalanceLoad = false;
    _willDeleteWalletId = "";
  }

  void _getBalance(WalletEntity entity, StateSetter _setState) async {
    _usdtBalance = await WalletMainModel.instance.getAWalletUsdtBalance(entity);
    if (_isShow && false == _isBalanceLoad) {
      _isBalanceLoad = true;
      _setState(() {});
    }
  }
}
