import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/cache_service/cache_keys.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/home/view/wallet_bottom_sheet.dart';
import 'package:wallet/pages/navigation_page.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/button/app_back_button.dart';
import 'package:wallet/widgets/menu_tile.dart';

class AboutMainPage extends StatefulWidget {
  AboutMainPage({Key? key}) : super(key: key);

  @override
  _AboutMainPageState createState() => _AboutMainPageState();
}

class _AboutMainPageState extends State<AboutMainPage> {
  List<Map> webList = [

  ];

  /// APP
  ValueNotifier _versionNotifier = ValueNotifier<String>('');

  String? _buildNumber;

  void getAppInfo() async {
    _versionNotifier.value = config.package.version;
    _buildNumber = config.package.buildNumber;
  }

  @override
  void initState() {
    super.initState();
    getAppInfo();
  }

  Widget makeItem(BuildContext context, Map map, bool isLast) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MenuTile(
            height: 56,
            title: Text(
              map['name'],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.of(context).currentColors.textColor1),
            ),
            trailing: Text(
              map['url'],
              style: TextStyle(fontSize: 14, color: AppTheme.of(context).currentColors.textColor3),
            ),
            onPressed: () async {
              if (!kIsWeb) {
                service.router.pushNamed(RouteName.webViewPage, arguments: map['url']);
              } else {
                await launch(map['url']);
              }
            }),
        if (!isLast)
          Divider(
              height: 1,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: AppTheme.of(context).currentColors.dividerColor),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _hasNewVersion = service.cache.getBool(hasNewVersionKey) ?? false;
    final appColors = context.appColors;
    // print('_AboutMainPageState.build666');
    return Scaffold(
      backgroundColor: AppTheme.of(context).currentColors.backgroundColor,
      appBar: WalletBar(
        showBackButton: true,
        leading: AppBackButton(),
        title: Text(
          "About Us",
          style: TextStyle(
              color: AppTheme.of(context).currentColors.textColor1,
              fontWeight: FontWeight.bold,
              fontSize: 24),
        ),
      ),
      body: DefaultTextStyle(
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.of(context).currentColors.textColor1),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40, bottom: 32),
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    children: [
                      config.app.appType == WalletAppType.slope
                          ? service.svg.asset("assets/svg/slope_icon.svg")
                          : service.svg.asset("assets/svg/slope_icon.svg"),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        config.app.appType == WalletAppType.slope ? 'Slope' : 'Slope Wallet',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.of(context).currentColors.textColor1),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      ValueListenableBuilder(
                          valueListenable: _versionNotifier,
                          builder: (context, value, child) => Text(
                                'Version $value',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.of(context).currentColors.textColor3),
                              )),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 0,
                margin: EdgeInsets.only(left: 24, right: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  side: BorderSide(
                    color: AppTheme.of(context).currentColors.dividerColor,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    MenuTile(
                      height: 56,
                      title: Text(
                        'Version Update',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.of(context).currentColors.textColor1),
                      ),
                      trailing: (_hasNewVersion)
                          ? Row(
                              children: [
                                Text(
                                  service.cache.getString(newVersionNumberKey, defaultValue: '') ??
                                      '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: appColors.textColor3,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text('●',
                                    style: TextStyle(
                                      fontSize: 6,
                                      fontWeight: FontWeight.w400,
                                      color: appColors.red,
                                    )),
                                const SizedBox(
                                  width: 4,
                                ),
                                navIcon,
                              ],
                            )
                          : Text(
                              'Latest',
                              style: TextStyle(fontSize: 14, color: appColors.textColor4),
                            ),
                      onPressed: !_hasNewVersion
                          ? null
                          : () {
                              String url =
                                  service.cache.getString(versionUpgradeUrlKey, defaultValue: '') ??
                                      '';
                              _launchURL(url);
                              redPointChangeNotifier.value = !redPointChangeNotifier.value;

                              // 
                              service.cache.setBool(newVersionLookKey, true);
                            },
                    ),
                    Divider(
                        height: 1,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        color: AppTheme.of(context).currentColors.dividerColor),
                    MenuTile(
                        height: 56,
                        title: Text(
                          'Helps',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.of(context).currentColors.textColor1),
                        ),
                        trailing: navIcon,
                        onPressed: () => service.router.pushNamed(RouteName.myFaqPage)),
                    Divider(
                        height: 1,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        color: AppTheme.of(context).currentColors.dividerColor),
                    MenuTile(
                        height: 56,
                        title: Text(
                          'Terms of use',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.of(context).currentColors.textColor1),
                        ),
                        trailing: navIcon,
                        onPressed: () async {
                          service.router.pushNamed(RouteName.serviceAgreementPage);
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                elevation: 0,
                margin: EdgeInsets.only(left: 24, right: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  side: BorderSide(
                    color: AppTheme.of(context).currentColors.dividerColor,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < webList.length; i++)
                      makeItem(context, webList[i], i == (webList.length - 1)),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Card(
                elevation: 0,
                margin: EdgeInsets.only(left: 24, right: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  side: BorderSide(
                    color: AppTheme.of(context).currentColors.dividerColor,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    // Website
                    MenuTile(
                        height: 56,
                        title: Text(
                          'Contact us',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.of(context).currentColors.textColor1),
                        ),
                        trailing: navIcon,
                        onPressed: () {
                          ShareContactUsModal.showView(
                            context: context,
                            contactInfos: const [
                              'Telegram: slopefinance',
                              'Email: hello@slope.finance',
                            ],
                            onCopy: (index) {
                              const copyText = [
                                'slopefinance',
                                'hello@slope.finance',
                              ];
                              return copyText[index];
                            },
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 16 + MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get navIcon {
    return service.svg.asset(
      Assets.assets_svg_ic_myprofile_menu_trailing_svg,
      fit: BoxFit.scaleDown,
      color: context.appColors.textColor1,
    );
  }
}
