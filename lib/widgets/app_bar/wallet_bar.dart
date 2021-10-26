import 'package:flutter/material.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/button/app_back_button.dart';

class WalletBar extends AppBar {
  WalletBar({
    bool? centerTitle = false,
    bool showBackButton = false,
    Widget? title,
    List<Widget>? actions,
    double? toolbarHeight = kToolbarHeight,
    Widget? leading = const AppBackButton(),
    double? leadingWidth,
  }) : super(
            automaticallyImplyLeading: showBackButton,
            leading: showBackButton
                ? Container(
                    constraints: BoxConstraints.tightFor(width: leadingWidth ?? 24),
                    margin:
                        EdgeInsets.only(left: config.app.appType == WalletAppType.slope ? 20 : 24),
                    alignment: Alignment.centerRight,
                    child: leading,
                  )
                : const SizedBox(),
            leadingWidth: leadingWidth != null ? 24 + leadingWidth : (showBackButton ? 48 : 24),
            titleSpacing: showBackButton ? 8 : 0,
            centerTitle: centerTitle,
            title: title,
            actions: actions,
            toolbarHeight: toolbarHeight);

  factory WalletBar.replacement() => WalletBar(toolbarHeight: 0);

  factory WalletBar.empty() => WalletBar(
        toolbarHeight: kToolbarHeight,
        leading: SizedBox(),
      );

  factory WalletBar.title(String title, {List<Widget>? actions}) => WalletBar(
      actions: actions,
      leading: SizedBox(width: 24),
      title: Builder(builder: (context) {
        return Text(
          title,
          style: TextStyle(
              color: AppTheme.of(context).currentColors.textColor1,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        );
      }));

  factory WalletBar.back() => WalletBar.backWithTitle('');



  factory WalletBar.backWithTitle(String title) => WalletBar(
        showBackButton: true,
        leading: AppBackButton(),
        title: Builder(builder: (context) {
          return Text(
            title,
            style: TextStyle(
                color: AppTheme.of(context).currentColors.textColor1,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          );
        }),
      );

  factory WalletBar.customBack({String? title, VoidCallback? onPressed}) => WalletBar(
    leading: AppBackButton(onPressed:onPressed),
    showBackButton: true,
    title: Builder(builder: (context) {
      return Text(
        title??'',
        style: TextStyle(
            color: AppTheme.of(context).currentColors.textColor1,
            fontSize: 24,
            fontWeight: FontWeight.bold),
      );
    }),
  );

  factory WalletBar.slopeWallet() => WalletBar.title("Slope Wallet");
}
