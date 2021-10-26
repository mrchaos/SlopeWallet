import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  ///、
  final Color primaryColor;

  ///
  final LinearGradient primaryGradient;

  // 
  final LinearGradient disableGradient;

  ///
  final Color assistRedColor;
  final Color assistYellowColor;
  final LinearGradient assistRedGradient;

  ///AppBar title text color, icon color
  final Color textColor1;
  final Color textColor2;
  final Color textColor3;
  final Color textColor4;
  final textColor5;

  final textColor6;
  final toastTextColor;

  final Color dividerColor;
  final Color cancelButtonColor;
  final Color backgroundColor;
  final Color dexDownArrowColor;

  // final Color cardColor;
  final Color onBackgroundColor;

  final MaterialColor primarySwatch;
  final Brightness brightness;

  ///
  final Color riseColor;

  ///
  final Color fallColor;
  final Color noChangeColor;

  ///BottomSheet
  final Color? barrierColor;

  ///：
  final lightGray;

  /// create wallet
  final Color createBackgroundColor;

  ///：
  final darkLightGray = const Color(0xFF1F2533);

  /// Fee Tiers 
  final FeeTiersSerialColor;

  ///：
  final darkMediumGray = const Color(0xFF1A1A1B);
  final cancelColor;

  ///：
  final darkGray = const Color(0xFF0E121A);

  /// loaddataColor
  final Color loadDataColor;

  /// market
  /// tabbar
  final unselectedLabelColor;

  ///：2
  final darkLightGray2 = const Color(0xFF202021);

  /// 
  final favorColor;

  /// appbar
  final marketSelectColor;

  /// trade
  final tradeTable;

  /// trader tab
  final buyAndSell;

  /// trader 
  final arrowsColor;

  /// trader OpenOrder AmountPrice
  final AmountAndPrice;

  ///，
  final blackTextInGreenAccent = const Color(0xFF292C33);

  final blackTextInFAQ = const Color(0xFF292C33);

  final subTextInFAQ = const Color(0xFF5C5F66);

  /// dex
  final dexCreateBtn;

  /// dexsliderColor
  final dexSliderColor;

  /// k rightRealTimeBgColorFn

  ///
  final randomColor =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
          .withOpacity(1.0);

  final white = const Color(0xFFFFFFFF);

  final purpleAccent = const Color(0xFF6E66FA);
  final purple;
  final purpleLight = const Color(0xFF6E66FA);
  final watchListBoredr;

  ///walletgreen
  final greenAccent = const Color(0xFF67EBBA);

  ///dexgreen
  final green = const Color(0xFF1BD1A8);

  /// 
  final alumniNewsShareDialogCancelBtnColor;

  /// wallet 
  final walletCancelBtnColor;

  final redAccent = const Color(0xFFF0665B);
  final red = const Color(0xFFF0665B);
  final textDetail = const Color(0xFF5F6570);
  final searchFocusColor;
  final yellowAccent = const Color(0xFFF7E14F);
  final yellow = const Color(0xFFFFCC00);

  /// browSearchBorder
  ///
  final browSearchBorderColor;

  /// 
  final DividerColors;

  /// ，
  final updateWalletNameCancelColor;

  //toast
  final toastColor;

  /// newsbanner;
  final newsBannerPointerActiveColor; // 
  final newsBannerPointerColor; // 

  AppColors({
    required this.newsBannerPointerColor,
    required this.brightness,
    required this.primarySwatch,
    required this.primaryColor,
    required this.primaryGradient,
    required this.disableGradient,
    required this.assistRedColor,
    required this.assistYellowColor,
    required this.assistRedGradient,
    required this.textColor1,
    required this.textColor2,
    required this.textColor3,
    required this.favorColor,
    required this.cancelColor,
    required this.textColor4,
    required this.textColor5,
    required this.textColor6,
    // required this.textColor7,
    required this.alumniNewsShareDialogCancelBtnColor,
    required this.toastTextColor,
    required this.arrowsColor,
    required this.lightGray,
    required this.searchFocusColor,
    required this.marketSelectColor,
    required this.walletCancelBtnColor,
    required this.purple,
    required this.tradeTable,
    required this.unselectedLabelColor,
    required this.createBackgroundColor,
    required this.watchListBoredr,
    required this.buyAndSell,
    required this.AmountAndPrice,
    required this.FeeTiersSerialColor,
    required this.dividerColor,
    required this.cancelButtonColor,
    required this.backgroundColor,
    required this.onBackgroundColor,
    required this.dexCreateBtn,
    required this.updateWalletNameCancelColor,
    required this.toastColor,
    required this.dexSliderColor,
    required this.dexDownArrowColor,
    required this.browSearchBorderColor,
    this.riseColor = const Color(0xFF1BD1A8),
    this.fallColor = const Color(0xFFF0665B),
    this.noChangeColor = const Color(0xFF919499),
    required this.loadDataColor,
    this.barrierColor,
    required this.DividerColors,
    required this.newsBannerPointerActiveColor,
  });

  factory AppColors.light() {
    const _kPrimaryColor = Color(0xFF594AF0);
    return AppColors(
      newsBannerPointerActiveColor: Color(0xff292C33),
      newsBannerPointerColor: Color(0xffF3F3F5),
      brightness: Brightness.light,
      primaryColor: _kPrimaryColor,
      dexCreateBtn: Color(0xFF6E66FA),
      updateWalletNameCancelColor: Color(0xFFF3F3F5),
      DividerColors: Color(0xffF3F3F5),
      primaryGradient: LinearGradient(
        colors: [Color(0xFF25CCBB), Color(0xFF28C7A2)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      loadDataColor: Color(0xffF7F8FA),
      disableGradient: LinearGradient(
        colors: [
          Color(0xFF25CCBB).withOpacity(0.5),
          Color(0xFF28C7A2).withOpacity(0.5)
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      alumniNewsShareDialogCancelBtnColor: Color(0xff919499),
      primarySwatch: MaterialColor(
        Color(0xFF594AF0).value,
        const <int, Color>{
          50: Color(0xFFF3E5F5),
          100: Color(0xFFE1BEE7),
          200: Color(0xFFCE93D8),
          300: Color(0xFFBA68C8),
          400: Color(0xFFAB47BC),
          500: Color(0xFF594AF0),
          600: Color(0xFF8E24AA),
          700: Color(0xFF7B1FA2),
          800: Color(0xFF6A1B9A),
          900: Color(0xFF4A148C),
        },
      ),
      lightGray: Color(0xFFF7F8FA),
      watchListBoredr: Color(0xFFF3F3F5),
      purple: Color(0xFF594AF0),
      createBackgroundColor: Color(0xffF7F8FA),
      assistRedColor: const Color(0xFFE55C65),
      unselectedLabelColor: Color(0xff332929),
      favorColor: Color(0xff292C33),
      arrowsColor: Color(0xffFFFFFF),
      marketSelectColor: Color(0xff292C33),
      tradeTable: Color(0xff919499),
      AmountAndPrice: Color(0xff919499),
      FeeTiersSerialColor: Color(0xff5C5F66),
      walletCancelBtnColor: Color(0xff919499),
      assistRedGradient: LinearGradient(
        colors: [Color(0xFFF0655D), Color(0xFFE55C65)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      assistYellowColor: const Color(0xFFF5AD49),
      textColor1: const Color(0xFF292C33),
      textColor2: const Color(0xFF5C5F66),
      textColor3: const Color(0xFF919499),
      textColor4: const Color(0xFFC8C9CC),
      textColor5: const Color(0xFFC8C9CC),
      textColor6: const Color(0xFF5C5F66),
      // textColor7:Color(0xff292C33),
      toastTextColor: const Color(0xFFFFFFFF),
      buyAndSell: const Color(0xFFF7F8FA),
      cancelColor: Color(0xFF919499),
      dividerColor: const Color(0xFFF3F3F5),
      cancelButtonColor: const Color(0xFFF7F8FA),
      backgroundColor: Colors.white,
      onBackgroundColor: const Color(0xFFF4F5F6),
      barrierColor: Colors.black.withOpacity(0.4),
      toastColor: const Color(0xFF292C33),
      noChangeColor: const Color(0xFF919499),
      riseColor: const Color(0xFF14CCA3),
      fallColor: const Color(0xFFF9584B),
      dexSliderColor: const Color(0xFFFFFFFF),
      dexDownArrowColor: const Color(0xFFFFFFFF),
      searchFocusColor: const Color(0xff292C33),
      browSearchBorderColor: const Color(0xff292C33),
    );
  }

  factory AppColors.dark() {
    return AppColors(
      newsBannerPointerActiveColor: Color(0xffE9ECF2),
      newsBannerPointerColor: Color(0xff242628),
      brightness: Brightness.dark,
      primaryColor: Color(0xFF1CB89E),
      dexCreateBtn: Color(0xFF27292B),
      alumniNewsShareDialogCancelBtnColor: Color(0xffA7ACB5),
      updateWalletNameCancelColor: Color(0xFF27292B),
      primaryGradient: LinearGradient(
        colors: [Color(0xFF25CCBB), Color(0xFF19BFAE), Color(0xFF16B59B)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      loadDataColor: Color(0xff1A1A1B),
      browSearchBorderColor: Color(0xffC4C4C4),
      DividerColors: Color(0xff27292B),
      disableGradient: LinearGradient(
        // colors: [Color(0xFF323947), Color(0xFF323947)],
        colors: [
          Color(0xFF25CCBB).withOpacity(0.5),
          Color(0xFF28C7A2).withOpacity(0.5)
        ],
      ),
      lightGray: Color(0xFF202021),
      watchListBoredr: Color(0xFF27292B),
      purple: Color(0xFF6E66FA),
      createBackgroundColor: Color(0xff27292B),
      unselectedLabelColor: Color(0xffE9ECF2),
      favorColor: Color(0xffE9ECF2),
      marketSelectColor: Color(0xff292C33),
      arrowsColor: Color(0xffE9ECF2),
      tradeTable: Color(0xff919499),
      AmountAndPrice: Color(0xffE9ECF2),
      walletCancelBtnColor: Color(0xffE9ECF2),
      FeeTiersSerialColor: Color(0xffA7ACB5),
      primarySwatch: MaterialColor(
        Color(0xFF28C7AC).value,
        const <int, Color>{
          50: Color(0xFFE0F2F1),
          100: Color(0xFFB2DFDB),
          200: Color(0xFF80CBC4),
          300: Color(0xFF4DB6AC),
          400: Color(0xFF26A69A),
          500: Color(0xFF1CB89E),
          600: Color(0xFF00897B),
          700: Color(0xFF00796B),
          800: Color(0xFF00695C),
          900: Color(0xFF004D40),
        },
      ),
      assistRedColor: const Color(0xFFD64B54),
      buyAndSell: const Color(0xFF27292B),
      assistRedGradient: LinearGradient(
        colors: [Color(0xFFE06251), Color(0xFFD64D56)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      assistYellowColor: const Color(0xFFF5AD49),
      textColor1: const Color(0xFFE9ECF2),
      textColor2: const Color(0xFF8D96A6),
      textColor3: const Color(0xFF69707D),
      textColor4: const Color(0xFF323947),
      textColor5: const Color(0xFF474D59),
      textColor6: const Color(0xFFA7ACB5),
      // textColor7:Color(0xff292C33),
      toastTextColor: const Color(0xFFE9ECF2),
      dividerColor: const Color(0xFF242628),
      cancelButtonColor: const Color(0xFF242628),
      cancelColor: Color(0xFF919499),
      backgroundColor: const Color(0xFF131314),
      onBackgroundColor: const Color(0xFF151A24),
      barrierColor: Colors.black.withOpacity(0.4),
      toastColor: const Color(0xFF474D59),
      noChangeColor: const Color(0xFF464C58),
      dexSliderColor: const Color(0xFF202021),
      dexDownArrowColor: const Color(0xFF242628),
      searchFocusColor: const Color(0xffE9ECF2),
    );
  }
}
