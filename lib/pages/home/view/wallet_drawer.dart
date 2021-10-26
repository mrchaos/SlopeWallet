import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/screen/screen_util.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/pages/home/view/menu_list_item.dart';
import 'package:wallet/pages/home/view/wallet_vertical_menu.dart';
import 'package:wallet/pages/profile/view/create_wallet_sheet.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/button/app_back_button.dart';

class WalletDrawer extends StatefulWidget {
  @override
  _WalletDrawerState createState() => _WalletDrawerState();
}

class _WalletDrawerState extends State<WalletDrawer> {
  List<WalletEntity> _wallets = [];
  int _currentMenuIdx = 0;

  void _initData(BuildContext context) {
    List<String> supportChains = context.watch<WalletMainModel>().supportedBlockChains;
    _wallets =
        context.watch<WalletMainModel>().getWalletsByBlockChain(supportChains[_currentMenuIdx]);
  }

  @override
  Widget build(BuildContext context) {
    _initData(context);
    return SizedBox(
      width: ScreenUtil.width(context) - 44,
      child: Drawer(
        child: Scaffold(
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
                  child: TextButton(
                      onPressed: () {
                        service.router.pushNamed(RouteName.walletListPage);
                      },
                      child: Text(
                        "Manage",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.of(context).currentColors.textColor1),
                      )))
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 15, right: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WalletVerticalMenu(
                            isFromDrawer: true,
                            trackSize: Size(4, 24),
                            iconSize: 28,
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
                        Expanded(
                            child: ListView.separated(
                                itemCount: _wallets.length,
                                separatorBuilder: (context, idx) => SizedBox(height: 16),
                                itemBuilder: (context, idx) {
                                  return MenuListItem(
                                    onTap: () {
                                      context.read<WalletMainModel>().currentWallet = _wallets[idx];
                                      Navigator.pop(context);
                                    },
                                    cardBg: _wallets[idx].walletCardBg,
                                    walletName: _wallets[idx].walletName,
                                    address: _wallets[idx].address.ellAddress(),
                                  );
                                  // return WalletListItem();
                                })),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 88,
                  padding: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
                  // color: Colors.red,
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        service.svg.asset(Assets.assets_svg_wallet_add_svg,
                            width: 20, height: 20, fit: BoxFit.scaleDown, color: Colors.white),
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
                      backgroundColor: MaterialStateProperty.all(
                          AppTheme.of(context).currentColors.purpleAccent),
                      padding: MaterialStateProperty.all(EdgeInsets.only(top: 12, bottom: 12)),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0))),
                    ),
                    onPressed: () {
                      // WalletCreateModel.instance.isFromDrawer = true;
                      showCreateWalletSheet(context,
                          context.read<WalletMainModel>().supportedBlockChains[_currentMenuIdx]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
