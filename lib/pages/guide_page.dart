import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/common/service/cache_service/cache_keys.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/widgets/gradient_button.dart';

///APP
class GuidePage extends StatelessWidget {
  final bool hasWallet = false;

  static const _icons = [
    Assets.assets_image_guide_pic_1_png,
    Assets.assets_image_guide_pic_2_png,
    Assets.assets_image_guide_pic_3_png,
  ];

  static const _titleList = [
    'SPL Transaction',
    'Exploration',
    'Solana Nucleus',
  ];

  List<List<TextSpan>> getContentSpanList(BuildContext context) {
    final appColors = AppTheme.of(context).darkColors;
    final norStyle = TextStyle(color: appColors.textColor6, fontSize: 16);
    return [
      [
        // Easy And Efficient Position Management
        TextSpan(
          text: 'Send & Receive Tokens & NFT',
          style: norStyle,
        ),
        TextSpan(text: 'No extra transaction cost', style: norStyle),
      ],
      [
        // Secured And Stable Trading System
        TextSpan(text: 'Connect with Solana DApps', style: norStyle),
        TextSpan(text: 'Anytime, Anywhere', style: norStyle),
      ],
      [
        // Prosperous Future Of Cryptocurrencies
        TextSpan(text: 'The Heartbeat of Solana ecosystem', style: norStyle),
        TextSpan(text: 'Get information Faster & Accurate', style: norStyle),
      ],
    ];
  }

  final ValueNotifier<int> _pageIndex = ValueNotifier(0);

  int get pageCount => _titleList.length;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: AppTheme.of(context).darkColors.darkGray,
          gradient: null,
        ),
        child: Scaffold(
          backgroundColor: AppTheme.of(context).darkColors.darkGray,
          body: AnnotatedRegion(
            value: (Theme.of(context).brightness != Brightness.dark
                    ? SystemUiOverlayStyle.dark
                    : SystemUiOverlayStyle.light)
                .copyWith(
              systemNavigationBarColor: AppTheme.of(context).currentColors.backgroundColor,
              systemNavigationBarIconBrightness: Theme.of(context).brightness != Brightness.dark
                  ? Brightness.dark
                  : Brightness.light,
            ),
            child: SafeArea(
              left: false,
              top: false,
              right: false,
              bottom: true,
              child: LayoutBuilder(builder: (context, box) {
                var pageHeight = box.maxHeight;
                return SizedBox(
                  height: pageHeight,
                  child: Stack(
                    children: [
                      PageView.builder(
                        onPageChanged: (index) => _pageIndex.value = index,
                        itemCount: pageCount,
                        itemBuilder: (c, index) => _Page(
                          pageHeight: pageHeight,
                          lastPage: index == _icons.length - 1,
                          icon: buildPicture(index),
                          title: buildTitle(index, c),
                          content: buildContent(index),
                        ),
                      ),
                      IgnorePointer(
                        ignoring: true,
                        child: _Page(
                          indicator: buildPageIndicator(),
                          pageHeight: pageHeight,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      );
    });
  }

  Widget buildContent(int index) => Builder(builder: (context) {
        return Column(
          children: List.generate(getContentSpanList(context)[index].length, (idx) {
            return Text.rich(
              TextSpan(
                children: [getContentSpanList(context)[index][idx]],
              ),
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            );
          }),
        );
      });

  Widget buildPicture(int index) => Image.asset(_icons[index]);

  Widget buildTitle(int index, context) => Text(
        _titleList[index],
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 32,
            height: 40 / 32,
            color: AppTheme.of(context).darkColors.textColor1),
      );

  Widget buildPageIndicator() {
    return ValueListenableBuilder<int>(
      valueListenable: _pageIndex,
      builder: (context, current, _) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Iterable.generate(
          pageCount,
          (index) => Container(
            width: 16,
            height: 3,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: index == current
                  ? AppTheme.of(context).darkColors.purpleAccent
                  : AppTheme.of(context).darkColors.textColor1.withOpacity(0.2),
            ),
          ),
        ).toList(growable: false),
      ),
    );
  }
}

///Iphone SE:
///（24），320-24*2=272,
///，，，，568()-272()-68()-44()-3()=181
///56.5 : 3.5 : 3.5 : 1.5 : 1.8，5181px
///569、38、38、16、20
///
class _Page extends StatelessWidget {
  final Widget? icon;
  final Widget? title;
  final Widget? content;
  final Widget? indicator;
  final bool lastPage;
  final double pageHeight;

  const _Page({
    Key? key,
    this.icon,
    this.title,
    this.content,
    this.indicator,
    this.lastPage = false,
    required this.pageHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // const allFlex = 69 + 38 + 38 + 16 + 20.0;
    //freeSpace: -214()-88()-56()-3()
    // 5:4:1:1:2(::......)
    var freeSpace = pageHeight - 214 - 88 - 56 - 3;
    var allFlex = freeSpace * (5 + 4 + 1 + 1 + 2);
    final flexHeight = pageHeight - 214 - 88 - 56 - 3;
    const minHeight = 568.0;
    return SingleChildScrollView(
      physics: pageHeight >= minHeight ? const NeverScrollableScrollPhysics() : null,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: freeSpace * 5 / allFlex * flexHeight),
            //
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              height: 240,
              child: icon,
            ),
            SizedBox(height: freeSpace * 4 / allFlex * flexHeight),
            //
            SizedBox(
              height: 88,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: title,
                    height: 40,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    child: content,
                    height: 40,
                  ),
                ],
              ),
            ),
            SizedBox(height: freeSpace * 1 / allFlex * flexHeight),
            // 
            Container(
              height: 56,
              margin: lastPage ? const EdgeInsets.symmetric(horizontal: 24) : EdgeInsets.zero,
              child: Visibility(
                visible: lastPage,
                child: GradientButton(
                  borderRadius: BorderRadius.circular(16),
                  text: 'Enter',
                  gradient: LinearGradient(colors: [
                    AppTheme.of(context).darkColors.purpleLight,
                    AppTheme.of(context).darkColors.purpleLight,
                  ]),
                  onPressed: () async {
                    service.cache.setBool(showGuidePageKey, true);

                    bool _hasWallet = await WalletManager().checkHasWallet();
                    service.router.pushReplacementNamed(
                        _hasWallet ? RouteName.walletPasswordPage : RouteName.createWalletPage);
                  },
                ),
              ),
            ),
            SizedBox(height: freeSpace * 1 / allFlex * flexHeight),
            SizedBox(
              height: 3,
              child: indicator,
            ),
            SizedBox(height: 20 / allFlex * flexHeight),
          ],
        ),
      ),
    );
  }
}
