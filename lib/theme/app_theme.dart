import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/config/i_config.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wd_common_package/wd_common_package.dart';

import 'app_colors.dart';
import 'no_splash.dart';

class ThemeModeSymbol {
  static const String system = "system";
  static const String light = "light";
  static const String dark = "dark";

  const ThemeModeSymbol._internal();
}

AppColors? _appColors;

extension ContextExt on BuildContext {
  bool get isLightTheme => this.brightness == Brightness.light;

  Brightness get brightness => Theme.of(this).brightness;

  AppColors get appColors => AppTheme.of(this).currentColors;
}

///app
// AppColors get appColors =>
//     _appColors ?? AppTheme.of(appRootContext).currentColors;

class AppTheme extends ViewModel with IConfig {
  static AppTheme of(context) => Provider.of<AppTheme>(context, listen: true);

  /// key
  static const String themeModeSymbolKey = "themeModeSymbolKey";

  /// dark
  static const String defaultSymbol = ThemeModeSymbol.dark;
  ThemeMode? _themeMode;

  ThemeMode get themeMode {
    if (null == _themeMode) {
      String modeSymbol = service.cache
          .getString(themeModeSymbolKey, defaultValue: defaultSymbol)!;
      switch (modeSymbol) {
        case ThemeModeSymbol.system:
          _themeMode = ThemeMode.system;
          break;
        case ThemeModeSymbol.light:
          _themeMode = ThemeMode.light;
          break;
        case ThemeModeSymbol.dark:
          _themeMode = ThemeMode.dark;
          break;
        default:
          _themeMode = ThemeMode.dark;
          break;
      }
    }
    return _themeMode!;
  }

  set themeMode(ThemeMode value) {
    _themeMode = value;
    String themeSymbol = ThemeModeSymbol.dark;
    switch (value) {
      case ThemeMode.system:
        themeSymbol = ThemeModeSymbol.system;
        break;
      case ThemeMode.light:
        themeSymbol = ThemeModeSymbol.light;
        break;
      case ThemeMode.dark:
        themeSymbol = ThemeModeSymbol.dark;
        break;
    }
    service.cache.setString(themeModeSymbolKey, themeSymbol);

    /// currentColorsnotifyListeners()
    currentColors = _appColorsMap[themeSymbol]!;
    _appColors = currentColors;
    notifyListeners();
  }

  final Map<String, AppColors> _appColorsMap = {};
  AppColors? _currentColors;

  AppColors get currentColors {
    if (null == _currentColors) {
      String symbol = service.cache
          .getString(themeModeSymbolKey, defaultValue: defaultSymbol)!;
      _currentColors = _appColorsMap[symbol]!;
    }
    return _currentColors!;
  }

  set currentColors(AppColors value) {
    _currentColors = value;

    notifyListeners();
  }

  AppColors get darkColors => _appColorsMap[ThemeModeSymbol.dark]!;

  AppColors get lightColors => _appColorsMap[ThemeModeSymbol.light]!;

  static const String _fontFamily = 'Roboto';

  ///
  ThemeData get lightThemeData {
    final _colors = _appColorsMap[ThemeModeSymbol.light]!;
    var lightThemeData = ThemeData(
      //
      primaryColorBrightness: Brightness.dark,
      brightness: Brightness.light,
      primarySwatch: _colors.primarySwatch,
      //Android、iOS Roboto
      typography: Typography.material2014(platform: TargetPlatform.android),
      fontFamily: _fontFamily,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
    );
    return _wrapCommonTheme(lightThemeData, _colors);
  }

  ///
  ThemeData get darkThemeData {
    final _colors = _appColorsMap[ThemeModeSymbol.dark]!;
    final darkThemeData = ThemeData(
      //
      primaryColorBrightness: Brightness.light,
      brightness: Brightness.dark,
      primarySwatch: _colors.primarySwatch,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: const Color(0xFF1F2533),
      ),
      canvasColor: _colors.dividerColor,
      //Android、iOS Roboto
      typography: Typography.material2014(platform: TargetPlatform.android),
      fontFamily: _fontFamily,
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: _colors.backgroundColor,
      ),
    );
    return _wrapCommonTheme(darkThemeData, _colors);
  }

  static ThemeData _wrapCommonTheme(
      ThemeData defaultTheme, AppColors appColors) {
    defaultTheme = defaultTheme.copyWith(
      primaryTextTheme:
          defaultTheme.primaryTextTheme.apply(fontFamily: _fontFamily),
      textTheme: defaultTheme.textTheme.apply(fontFamily: _fontFamily),
      accentTextTheme:
          defaultTheme.accentTextTheme.apply(fontFamily: _fontFamily),
    );

    return defaultTheme.copyWith(
      indicatorColor: appColors.primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: defaultTheme.appBarTheme.copyWith(
        elevation: 0,
        color: appColors.backgroundColor,
        //
        centerTitle: false,
        brightness: defaultTheme.brightness,
        titleSpacing: 4,
      ),
      toggleableActiveColor: appColors.primaryColor,
      //
      splashFactory: NoSplashFactory(),
      // //
      // highlightColor: Colors.transparent,
      // cursorColor: appColors.primaryColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: appColors.primaryColor,
      ),
      // textSelectionColor: appColors.primaryColor.withOpacity(0.5),
      accentColor: appColors.primaryColor,
      primaryColorBrightness: appColors.brightness,
      primaryTextTheme: defaultTheme.primaryTextTheme.copyWith(
        //AppBar title
        headline6: defaultTheme.primaryTextTheme.headline6?.copyWith(
          fontSize: 24,
          color: appColors.textColor1,
          fontWeight: FontWeight.w700,
        ),
      ),

      primaryIconTheme:
          defaultTheme.primaryIconTheme.copyWith(color: appColors.textColor1),
      scaffoldBackgroundColor: appColors.backgroundColor,
      dividerColor: appColors.dividerColor,
      dividerTheme: defaultTheme.dividerTheme.copyWith(
        color: appColors.dividerColor,
        thickness: 1,
      ),
      iconTheme: defaultTheme.iconTheme.copyWith(color: appColors.textColor1),
      // buttonTheme: defaultTheme.buttonTheme.copyWith(),
      textTheme: defaultTheme.textTheme.copyWith(
        // fontSize: 14
        bodyText2: defaultTheme.textTheme.bodyText2
            ?.copyWith(color: appColors.textColor1),
        caption: defaultTheme.textTheme.caption
            ?.copyWith(color: appColors.textColor3),
      ),
      // //tabbar
      tabBarTheme: defaultTheme.tabBarTheme.copyWith(
        labelColor: appColors.textColor1,
        unselectedLabelColor: appColors.textColor3,
        indicatorSize: TabBarIndicatorSize.label,
        labelPadding: EdgeInsets.zero,
        indicator: const BoxDecoration(),
        labelStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: appColors.textColor1,
          fontFamily: _fontFamily,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: appColors.textColor1,
          fontFamily: _fontFamily,
        ),
      ),
      disabledColor: appColors.textColor3,
      dialogTheme: defaultTheme.dialogTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        titleTextStyle: (defaultTheme.dialogTheme.titleTextStyle ??
                defaultTheme.textTheme.headline6)
            ?.copyWith(
                fontSize: 17, height: 22 / 17, fontWeight: FontWeight.w600),
      ),
      bottomNavigationBarTheme: defaultTheme.bottomNavigationBarTheme.copyWith(
          selectedLabelStyle: const TextStyle(fontSize: 12),
          unselectedLabelStyle:
              TextStyle(fontSize: 12, color: appColors.textColor1),
          unselectedItemColor: appColors.textColor1,
          unselectedIconTheme: IconThemeData(color: appColors.textColor1)),
      bottomSheetTheme: defaultTheme.bottomSheetTheme.copyWith(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: defaultTheme.brightness,
      ),
    );
  }

  @override
  Future<void>? init() {
    _appColorsMap[ThemeModeSymbol.dark] = AppColors.dark();
    _appColorsMap[ThemeModeSymbol.light] = AppColors.light();
    _appColorsMap[ThemeModeSymbol.system] = AppColors.light();
    return null;
  }
}

extension _ThemeModeExt on ThemeMode {
  String get value {
    String _value;
    switch (this) {
      case ThemeMode.system:
        _value = 'system';
        break;
      case ThemeMode.light:
        _value = 'light';
        break;
      case ThemeMode.dark:
        _value = 'dark';
        break;
    }
    return _value;
  }
}
