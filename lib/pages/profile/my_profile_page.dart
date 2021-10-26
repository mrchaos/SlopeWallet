import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/cache_service/cache_keys.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/utils/bio_manager.dart';
import 'package:wallet/widgets/Dialog/public_dialog.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wallet/widgets/menu_tile.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late AppColors appColors;

  ///：WalletdarkMode，Dex
  bool shouldShowDarkMode = true;

  // 
  bool shouldShowAuth = false;

  // 
  final ValueNotifier<bool> bioNotifier = ValueNotifier(false);

  checkAuth() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var showAuth = await supportedBiometrics();
      setState(() {
        shouldShowAuth = showAuth;
      });
    });
  }

  getAuth() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      var showAuth = await enableBiometrics();
      if (showAuth) {
        // 
        bioNotifier.value =
            service.cache.getBool(hasBioBeenSetKey, defaultValue: false)!;
      } else {
        bioNotifier.value = false;
        service.cache.setBool(hasBioBeenSetKey, false);
      }
    });
  }

  @override
  void initState() {
    // 
    checkAuth();
    getAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    shouldShowDarkMode = (config.app.appType == WalletAppType.independence);
    appColors = context.appColors;

    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: config.app.appType == WalletAppType.slope
          ? WalletBar.backWithTitle("Settings")
          : WalletBar.title(
              "My Profile",
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.only(right: 24),
              //     child: GestureDetector(
              //       behavior: HitTestBehavior.opaque,
              //       onTap: () {
              //         service.router.pushNamed(RouteName.notificationPage);
              //       },
              //       child: service.svg.asset(
              //           Assets.assets_svg_profile_notify_svg,
              //           color: context.isLightTheme
              //               ? Color(0xff292C33)
              //               : Colors.white),
              //     ),
              //   )
              // ],
            ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            margin: EdgeInsets.only(left: 24, right: 24),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppTheme.of(context).currentColors.dividerColor,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: Column(
              children: [
                MenuTile(
                  height: 56,
                  borderRadius: BorderRadius.circular(8),
                  title: Text(
                    'My Wallet',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.of(context).currentColors.textColor1),
                  ),
                  onPressed: () {
                    service.router
                        .pushNamed(RouteName.walletListPage, arguments: false);
                  },
                  trailing: service.svg.asset(
                      Assets.assets_svg_ic_myprofile_menu_trailing_svg,
                      fit: BoxFit.scaleDown,
                      color: appColors.textColor1),
                ),
                Divider(
                    height: 1,
                    thickness: 1,
                    indent: 0,
                    endIndent: 0,
                    color: appColors.dividerColor),
                MenuTile(
                  height: 56,
                  borderRadius: BorderRadius.circular(8),
                  title: Text(
                    'Change Password',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: appColors.textColor1),
                  ),
                  onPressed: () {
                    service.router.pushNamed(RouteName.walletPasswordPage,
                        arguments: WalletCreateRelatedData(
                            isChangePasswordVerify: true));
                  },
                  trailing: service.svg.asset(
                      Assets.assets_svg_ic_myprofile_menu_trailing_svg,
                      fit: BoxFit.scaleDown,
                      color: appColors.textColor1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppTheme.of(context).currentColors.dividerColor,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: MenuTile(
              height: 56,
              borderRadius: BorderRadius.circular(8),
              title: Text(
                'Change Network',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.of(context).currentColors.textColor1),
              ),
              onPressed: () {
                service.router.pushNamed(RouteName.changeNetwork);
              },
              trailing: service.svg.asset(
                  Assets.assets_svg_ic_myprofile_menu_trailing_svg,
                  fit: BoxFit.scaleDown,
                  color: AppTheme.of(context).currentColors.textColor1),
            ),
          ),
          Card(
            elevation: 0,
            margin: EdgeInsets.only(left: 24, right: 24),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppTheme.of(context).currentColors.dividerColor,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: Column(
              children: [
                shouldShowAuth
                    ? MenuTile(
                        height: 56,
                        borderRadius: BorderRadius.circular(8),
                        title: Text(
                          'Face ID / Touch ID',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppTheme.of(context)
                                  .currentColors
                                  .textColor1),
                        ),
                        onPressed: () {
                          _onAuthModeChange();
                        },
                        trailing: ValueListenableBuilder<bool>(
                            valueListenable: bioNotifier,
                            builder: (c, dynamic value, _) {
                              return CupertinoSwitch(
                                activeColor: appColors.purpleAccent,
                                onChanged: (enable) => _onAuthModeChange(),
                                value: value,
                              );
                            }),
                      )
                    : SizedBox(),
                if (shouldShowAuth)
                  Divider(
                      height: 1,
                      thickness: 1,
                      indent: 0,
                      endIndent: 0,
                      color: appColors.dividerColor),
                shouldShowDarkMode
                    ? MenuTile(
                        height: 56,
                        borderRadius: BorderRadius.circular(8),
                        title: Text(
                          'Light Mode',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppTheme.of(context)
                                  .currentColors
                                  .textColor1),
                        ),
                        onPressed: () {
                          _onLightModeChange(context, !context.isLightTheme);
                        },
                        trailing: CupertinoSwitch(
                          activeColor: appColors.purpleAccent,
                          onChanged: (isLight) =>
                              _onLightModeChange(context, isLight),
                          value: context.isLightTheme,
                        ),
                      )
                    : Container(),
                shouldShowDarkMode
                    ? Divider(
                        height: 1,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        color: AppTheme.of(context).currentColors.dividerColor)
                    : Container(),
                MenuTile(
                  height: 56,
                  borderRadius: BorderRadius.circular(8),
                  title: Text(
                    'Language',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.of(context).currentColors.textColor1),
                  ),
                  onPressed: () {
                    // service.router.pushNamed(RouteName.myProfileLanguage);
                  },
                  trailing: Text(
                    'English',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.of(context).currentColors.textColor3),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            margin: EdgeInsets.only(left: 24, right: 24),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: AppTheme.of(context).currentColors.dividerColor,
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            child: MenuTile(
              height: 56,
              borderRadius: BorderRadius.circular(8),
              title: Text(
                'About Us',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.of(context).currentColors.textColor1),
              ),
              onPressed: () {
                service.router.pushNamed(RouteName.aboutMainPage);
              },
              trailing: Row(
                children: [
                  if (true ==
                      service.cache
                          .getBool(hasNewVersionKey, defaultValue: false))
                    Text(
                      '●', //'New version',
                      style: TextStyle(
                        color: appColors.redAccent,
                        fontSize: 6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  const SizedBox(
                    width: 4,
                  ),
                  service.svg.asset(
                      Assets.assets_svg_ic_myprofile_menu_trailing_svg,
                      fit: BoxFit.scaleDown,
                      color: AppTheme.of(context).currentColors.textColor1),
                ],
              ),
            ),
          ),
          if (isSlopeDex)
            SafeArea(
              child: Container(
                height: 56,
                margin: EdgeInsets.only(bottom: 16),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ElevatedButton(
                  child: Text(
                    'Disconnect',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        height: 22 / 18),
                  ),
                  onPressed: () {
                    showAlertVerticalButtonDialog(
                        context: context,
                        showSubButton: false,
                        barrierColor: Colors.black.withOpacity(0.4),
                        barrierDismissible: true,
                        mainButtonPressed: () async {
                          service.router.pop();
                          showLoading();
                          await context
                              .read<WalletMainModel>()
                              .slopeDisConnectWallet();
                          dismissLoading();
                          service.router.pop();
                        },
                        mainButtonLabel: "confirm",
                        title: "Disconnect Wallet",
                        content:
                            "Make sure you have back up your Mnemonic word.You need to use the Mnemonic words to re-connect the wallet.");
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(appColors.purpleAccent),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0))),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onAuthModeChange() async {
    // true，false
    bool successCheck = await showGuideThenCheck(context, timesLimitString: 'Too many times failures. Try again later.');
    if (!successCheck) return;

    // 
    bool isOpen = service.cache.getBool(hasBioBeenSetKey, defaultValue: false)!;
    service.cache.setBool(hasBioBeenSetKey, !isOpen);
    // 
    bioNotifier.value = !isOpen;
  }

  void _onLightModeChange(BuildContext context, bool isLightMode) {
    setState(() {
      SystemUiOverlayStyle uiOverlayStyle;
      ThemeMode themeMode;
      if (isLightMode) {
        themeMode = ThemeMode.light;
        uiOverlayStyle = SystemUiOverlayStyle(
          //
          statusBarColor: Colors.white,
          //Icon
          statusBarIconBrightness: Brightness.dark,
          //iOS
          statusBarBrightness: Brightness.dark,
        );
      } else {
        themeMode = ThemeMode.dark;
        uiOverlayStyle = SystemUiOverlayStyle(
          //
          statusBarColor: Colors.black,
          //Icon
          statusBarIconBrightness: Brightness.light,
          //iOS
          statusBarBrightness: Brightness.light,
        );
      }

      SystemChrome.setSystemUIOverlayStyle(uiOverlayStyle);
      context.read<AppTheme>().themeMode = themeMode;
    });
  }
}
