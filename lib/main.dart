import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wallet/common/util/navigate_service/navigate_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/generated/l10n.dart';
import 'package:wallet/main_model.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/widgets/app_provider/app_provider.dart';
import 'package:wd_common_package/wd_common_package.dart';

import 'common/config/wallet_config.dart';
import 'common/service/cache_service/cache_keys.dart';
import 'common/service/router_service/router_table.dart';
import 'common/service/wallet_service.dart';
import 'http_overrides.dart';
import 'sentry_report.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await service.init();
  //serviceconfig
  await config.init();
  bool hasWallet = await walletManager.checkHasWallet();

  // ，，
  bool showGuide = service.cache.getBool(showGuidePageKey, defaultValue: false)!;
  runApp(AppProvider.wrapGlobalProviders(MyApp(
    hasWallet: hasWallet,
    showGuide: showGuide,
  )));

  //
  if (!kIsWeb && Platform.isAndroid) {
    final SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  final bool hasWallet;
  final bool showGuide;

  const MyApp({Key? key, this.hasWallet = false, required this.showGuide}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  StreamSubscription? _sub;

  @override
  initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();

  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _sub?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    logger.d("-didChangeAppLifecycleState-" + state.toString());
    if (state == AppLifecycleState.resumed) {
      _platformStateForStringUniLinks();
    }
  }

  _initPlatformStateForStringUniLinks() async {
    String initialLink;
    try {
      initialLink = (await getInitialLink())!;
      logger.d('initialLink:${initialLink}');
      if (initialLink != null) {
        MainModel.instance.setIsJumpNews = true;
      } else {
        MainModel.instance.setIsJumpNews = false;
      }
    } catch (e) {
      MainModel.instance.setIsJumpNews = false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Builder(builder: (ctx) {
      return RefreshConfiguration(
        headerBuilder: () => Builder(
          builder: (context) {
            final refreshIcon =
                ({String image = Assets.assets_image_refresh_pull_png}) => Image.asset(
                      image,
                      width: 60,
                      height: 60,
                    );

            final imgIcon = refreshIcon(
                image: context.isLightTheme
                    ? Assets.assets_image_refresh_pull_png
                    : Assets.assets_image_refresh_pull_dark_png);

            return ClassicHeader(
                refreshingText: '',
                releaseText: '',
                idleText: '',
                completeText: '',
                completeIcon: null,
                spacing: 0,
                refreshingIcon: refreshIcon(
                    image: context.isLightTheme
                        ? Assets.assets_image_refreshing_light_gif
                        : Assets.assets_image_refreshing_gif),
                releaseIcon: imgIcon,
                idleIcon: imgIcon);
          },
        ),
        footerBuilder: () => ClassicFooter(),

        ///
        headerTriggerDistance: 40,

        ///
        maxOverScrollExtent: 16,

        ///
        maxUnderScrollExtent: 0,

        /// Viewport,
        hideFooterWhenNotFull: true,

        ///
        enableBallisticLoad: true,
        child: MaterialApp(
          title: 'Slope Wallet',
          key: service.router.appKey,
          themeMode: AppTheme.of(ctx).themeMode,
          theme: config.app.theme.lightThemeData,
          darkTheme: config.app.theme.darkThemeData,
          navigatorKey: rootNavigateService.key,
          navigatorObservers: [service.router, SentryNavigatorObserver()],
          onGenerateRoute: (RouteSettings settings) => service.router.generateRoute(settings),
          localizationsDelegates: [
            S.delegate,
            RefreshLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            ...GlobalCupertinoLocalizations.delegates,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale.fromSubtags(languageCode: 'en'),
          builder: EasyLoading.init(builder: _customChild),
          initialRoute: !widget.showGuide
              ? RouteName.walletGuidePage
              : (widget.hasWallet
                  ? (kIsWeb ? RouteName.webReLoginPage : RouteName.walletPasswordPage)
                  : RouteName.createWalletPage),
          // initialRoute: RouteName.createWalletPage,
        ),
      );
    });
  }

  Widget _customChild(BuildContext context, Widget? child) {
    bool dark = AppTheme.of(context).themeMode == ThemeMode.dark;
    Brightness brightness = dark ? Brightness.light : Brightness.dark;
    SystemUiOverlayStyle systemUiOverlayStyle =
        (dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light).copyWith(
      systemNavigationBarColor: context.isLightTheme
          ? Colors.white
          : context.read<AppTheme>().currentColors.backgroundColor,
      systemNavigationBarIconBrightness: brightness,
    );

    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.blue
      ..textColor = (AppTheme.of(context).themeMode == ThemeMode.light
          ? AppTheme.of(context).currentColors.toastTextColor
          : AppTheme.of(context).currentColors.toastTextColor)
      ..backgroundColor = (AppTheme.of(context).themeMode == ThemeMode.light
          ? AppTheme.of(context).currentColors.toastColor
          : AppTheme.of(context).currentColors.toastColor)
      ..radius = 8
      ..contentPadding = const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16)
      ..textStyle = EasyLoading.instance.textStyle?.copyWith(fontSize: 12)
      ..progressColor = Colors.white;

    EasyLoading.instance.successWidget = service.image.asset(Assets.assets_image_hud_success_png);

    EasyLoading.instance.errorWidget = service.image.asset(Assets.assets_image_hud_error_png);

    ///
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: GestureDetector(
        child: child,
        behavior: HitTestBehavior.opaque,
        onTap: () => _hideKeyboard(context),
      ),
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
