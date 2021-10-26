import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallet/common/service/cache_service/cache_keys.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/navigate_service/navigate_service.dart';
import 'package:wallet/data/apis/version_control_api.dart';
import 'package:wallet/main_model.dart';
import 'package:wallet/pages/alumni/alumni_home_page.dart';
import 'package:wallet/pages/home/view/wallet_drawer.dart';
import 'package:wallet/pages/navigation_model.dart';
import 'package:wallet/pages/profile/my_profile_page.dart';
import 'package:wallet/pages/swap/swap_convert_provider.dart';
import 'package:wallet/pages/swap/token_swap_page.dart';
import 'package:wallet/pages/tab_config.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/Dialog/public_dialog.dart';
import 'package:wd_common_package/wd_common_package.dart';

import '../generated/assets.dart';
import 'browser/browser_home_page.dart';
import 'home/wallet_main_page.dart';

final drawerStateKey = GlobalKey<ScaffoldState>();
final _navKey = GlobalKey<_NavigationPageState>();
ValueNotifier<bool> redPointChangeNotifier = ValueNotifier(false);

TabConfig getTabConfig(TabLabel tabLabel) {
  final conf = cacheVersionControl.firstWhereOrNull((elem) => elem.models == tabLabel.name);
  return conf?.tabConfig ?? TabConfig.showAndEnable;
}

navigateTo(TabLabel label) => _navKey.currentState?.navigateTo(label);

class NavigationPage extends StatefulWidget {
  NavigationPage() : super(key: _navKey);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

enum UniLinksType { string, uri }

class _NavigationPageState extends State<NavigationPage> with SingleTickerProviderStateMixin {
  var _tabPages = <_TabPage>[];

  int _indexNum = 0;

  ValueNotifier _isShowNavigation = ValueNotifier<bool>(true);

  late WalletDrawer _drawer;

  late NavigationModel _navigationModel;

  late MainModel _mainModel;

  navigateTo(TabLabel label) {
    var index = _tabPages.indexWhere((item) => item.tab == label);
    if (index >= 0) {
      setState(() {
        _indexNum = index;
      });
    }
  }

  StreamSubscription? _sub;

  @override
  void initState() {
    _drawer = WalletDrawer();
    _navigationModel = NavigationModel();

    super.initState();
    _getSystemConfig();

    MainModel.instance.addListener(_isJumpNewsChange);
  }

  @override
  void dispose() {
    super.dispose();
    MainModel.instance.removeListener(_isJumpNewsChange);
  }

  _isJumpNewsChange() {
    if (MainModel.instance.isJumpNews) {
      setState(() {
        List.generate(_tabPages.length, (index) {
          if (_tabPages[index].title == 'alumni') {
            _indexNum = index;
          }
        });
      });
    }
  }


  _getSystemConfig() async {
    _tabPages = [
      _TabPage(
        title: TabLabel.home.name,
        tab: TabLabel.home,
        page: WalletMainPage(),
        icon: Assets.assets_image_tab_home_normal_png,
        activeIcon: Assets.assets_image_tab_home_selected_png,
      ),
      _TabPage(
        title: TabLabel.alumni.name,
        tab: TabLabel.alumni,
        page: AlumniHomePage(),
        icon: Assets.assets_image_tab_alumni_png,
        activeIcon: Assets.assets_image_tab_alumni_active_png,
      ),
      _TabPage(
        title: TabLabel.profile.name,
        tab: TabLabel.profile,
        page: MyProfilePage(),
        icon: Assets.assets_image_tab_me_normal_png,
        activeIcon: Assets.assets_image_tab_me_selected_png,
      ),
    ];
    //
    _navigationModel.getVersionInfo().then((data) {
      if (null != data) {
        if (1 == data.forceStatus) {
          showVersionCheckDialog(
              title: 'New Version ' + data.lastVersion,
              content: data.versionInfo,
              context: appRootContext,
              showSubButton: false,
              mainButtonPressed: () {
                _launchURL(data.linkUrl.isNotEmpty ? data.linkUrl : 'https://slope.finance/#/');
              });
        } else {
          // 
          int? lastStamp = service.cache.getInt(data.lastVersion, defaultValue: 0);
          DateTime dateNow = DateTime.now();
          DateTime dateLast = DateTime.fromMillisecondsSinceEpoch(lastStamp ?? 0);
          int dif1Days = dateNow.difference(dateLast).inDays;
          if (1 <= dif1Days || (0 == lastStamp || null == lastStamp)) {
            service.cache.setInt(data.lastVersion, dateNow.millisecondsSinceEpoch);
            showVersionCheckDialog(
                title: 'New Version ' + data.lastVersion,
                content: data.versionInfo,
                context: appRootContext,
                showSubButton: true,
                mainButtonPressed: () {
                  Navigator.pop(appRootContext);
                  _launchURL(data.linkUrl.isNotEmpty ? data.linkUrl : 'https://slope.finance/');
                },
                subButtonPressed: () {
                  Navigator.pop(appRootContext);
                });
          }
        }
      }
    });
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  static const _kDotRadius = 3.0;
  static const _kNavIconSize = 24.0;

  Widget _iconWithRedPoint(String icon, String title) {
    bool _hasNewVersion = service.cache.getBool(hasNewVersionKey, defaultValue: false) ?? false;
    return ValueListenableBuilder(
        valueListenable: redPointChangeNotifier,
        builder: (context, value, child) {
          bool _hasLookNewVersion =
              service.cache.getBool(newVersionLookKey, defaultValue: false) ?? false;
          return Stack(
            alignment: Alignment.center,
            children: [
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                sizeCurve: Curves.ease,
                firstCurve: Curves.ease,
                secondCurve: Curves.ease,
                firstChild: service.image.asset(icon),
                secondChild: service.image.asset(icon),
                crossFadeState: CrossFadeState.showFirst,
              ),
              SizedOverflowBox(
                size: const Size(
                  _kNavIconSize + 2 * _kDotRadius,
                  _kNavIconSize + 2 * _kDotRadius,
                ),
                alignment: Alignment.topRight,
                child: Visibility(
                  visible: (title == 'profile') && (_hasNewVersion && !_hasLookNewVersion),
                  child: CircleAvatar(
                    radius: _kDotRadius,
                    backgroundColor: context.appColors.assistRedColor,
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return _navigationModel;
      },
      child: Scaffold(
        key: drawerStateKey,
        drawer: _indexNum == 0 ? _drawer : null,
        body: IndexedStack(
          index: _indexNum,
          children: [
            for (var index = 0; index < _tabPages.length; index++)
              TickerMode(
                enabled: _indexNum == index,
                child: _tabPages[index].page,
              ),
          ],
        ),
        bottomNavigationBar:
            Selector(builder: (BuildContext c, bool isSelectWalletDrawerOpen, Widget? widget) {
          return Offstage(
            offstage: isSelectWalletDrawerOpen,
            child: ValueListenableBuilder(
              valueListenable: _isShowNavigation,
              builder: (BuildContext context, value, Widget? child) {
                if (_isShowNavigation.value) {
                  return Selector<MainModel, bool>(
                      selector: (_, vm) => vm.isJumpNews,
                      builder: (_, data, __) {
                        return BottomNavigationBar(
                          elevation: 0,
                          backgroundColor: AppTheme.of(context).currentColors.backgroundColor,
                          // backgroundColor: Provider.of<AppTheme>(context).currentColors.backgroundColor,
                          //
                          unselectedLabelStyle: const TextStyle(fontSize: 0),
                          selectedLabelStyle: const TextStyle(fontSize: 0),
                          items: [
                            ..._tabPages.map((e) => BottomNavigationBarItem(
                                  // label: e.title,
                                  // tooltip: e.title,
                                  label: '',
                                  tooltip: '',
                                  // icon: service.image.asset(_tabPages[index].icon),
                                  // icon: service.image.asset(e.icon),
                                  icon: _iconWithRedPoint(e.icon, e.title ?? ''),
                                  activeIcon: _iconWithRedPoint(e.activeIcon!, e.title ?? ''),
                                )),
                          ],
                          iconSize: 24,
                          currentIndex: _indexNum,
                          type: BottomNavigationBarType.fixed,
                          onTap: (index) {
                            if (_indexNum != index) {
                              setState(() {
                                _indexNum = index;
                              });
                            }
                          },
                        );
                      });
                } else {
                  return SizedBox();
                }
              },
            ),
          );
        }, selector: (c, SwapConvertProvider provider) {
          return provider.isSelectWalletDrawerOpen;
        }),
      ),
    );
  }
}

enum TabLabel {
  home,
  alumni,
  profile,
}

extension TabLabelExt on TabLabel {
  String get name {
    var _name = '';
    switch (this) {
      case TabLabel.home:
        _name = 'home';
        break;
        break;
      case TabLabel.alumni:
        _name = 'alumni';
        break;
      case TabLabel.profile:
        _name = 'profile';
        break;
    }
    return _name;
  }
}

class _TabPage {
  final String? title;
  final String icon;
  final String? activeIcon;
  final Widget page;
  final TabLabel tab;

  _TabPage({
    this.title,
    required this.tab,
    required this.icon,
    this.activeIcon,
    required this.page,
  });
}
