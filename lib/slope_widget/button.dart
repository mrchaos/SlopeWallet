import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/theme/app_theme.dart';
class SlopeConfirmButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? margin;

  const SlopeConfirmButton({
    Key? key,
    this.text = 'Confirm',
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.height = 48,
    this.width,
    this.onPressed,
    this.margin,
    //todo: 16
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SlopButton(
      text: text,
      backgroundColor:
          backgroundColor ?? Theme.of(context).accentColor.withOpacity(onPressed == null ? 0.5 : 1),
      textColor: textColor ?? Colors.white,
      textStyle: textStyle,
      height: height,
      width: width,
      onPressed: onPressed,
      borderRadius: borderRadius,
      margin: margin,
    );
  }
}

class SlopeCancelButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double height;
  final double? width;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? margin;

  const SlopeCancelButton({
    Key? key,
    this.text = 'Cancel',
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.height = 48,
    this.width,
    this.onPressed,
    this.margin,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SlopButton(
      text: text,
      backgroundColor: backgroundColor,
      textColor: textColor,
      textStyle: textStyle,
      height: height,
      width: width,
      onPressed: onPressed,
      borderRadius: borderRadius,
      margin: margin,
    );
  }
}

class _SlopButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double height;
  final double? width;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final double? elevation;
  final EdgeInsetsGeometry? margin;

  const _SlopButton({
    Key? key,
    this.text = 'Cancel',
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.height = 48,
    this.width,
    this.onPressed,
    //todo: 16
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.elevation = 0,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text),
        style: TextButton.styleFrom(
          elevation: elevation,
          backgroundColor: backgroundColor ?? context.appColors.cancelButtonColor,
          primary: textColor ?? (context.isLightTheme?context.appColors.textColor3:context.appColors.textColor2),
          onSurface: textColor ??(context.isLightTheme?context.appColors.textColor3:context.appColors.textColor2),
          fixedSize: width != null ? Size(width!, height) : Size.fromHeight(height),
          minimumSize: width != null ? Size(width!, height) : Size.fromHeight(height),
          shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.zero),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ).merge(textStyle),
        ),
      ),
    );
  }
}

@immutable
class SlopeCheckBox extends StatelessWidget {
  bool value;
  final ValueChanged<bool>? onChange;

  SlopeCheckBox({
    Key? key,
    this.value = false,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (c, setState) => GestureDetector(
        onTap: () {
          setState(() {
            value = !value;
            onChange?.call(value);
          });
        },
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          firstChild: service.svg.asset(
            Assets.assets_svg_ic_terms_of_use_uncheck_svg,
            color: c.appColors.textColor4,
          ),
          secondChild: service.svg.asset(
            context.isLightTheme
                ? Assets.assets_svg_ic_terms_of_use_check_light_svg
                : Assets.assets_svg_ic_terms_of_use_check_dark_svg,
          ),
          crossFadeState: value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ),
    );
  }
}
