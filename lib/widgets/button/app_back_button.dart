import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/public_function/public_function.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';

///
class AppBackButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? onPressed;

  const AppBackButton({Key? key, this.color, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: service.svg.asset(
        Assets.assets_svg_ic_back_svg,
        color: color ?? AppTheme.of(context).currentColors.textColor1,
        // fit: BoxFit.contain,
      ),
      padding: EdgeInsets.zero,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}

