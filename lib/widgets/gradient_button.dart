import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/theme/app_theme.dart';

class GradientButton extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final VoidCallback? onPressed;
  final Gradient? gradient;

  // final Gradient disGradient;
  // final Color disableColor;
  final BorderRadius? borderRadius;
  final double width;
  final double height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;

  const GradientButton({
    Key? key,
    this.text,
    this.style,
    this.onPressed,
    this.gradient,
    // this.disGradient,
    // this.disableColor,
    this.borderRadius,
    this.width = 0,
    this.height = 44.0,
    this.constraints,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final appColors = AppTheme.of(context).currentColors;
    final buttonTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: Colors.white,
    ).merge(style).copyWith(color: Colors.white);
    final buttonHeight = height;
    var disable = onPressed == null;
    // disable = true;
    Widget child = Container(
      width: width,
      height: buttonHeight,
      constraints: constraints ??
          BoxConstraints(
              minWidth: double.maxFinite,
              minHeight: buttonHeight,
              maxHeight: buttonHeight),
      decoration: BoxDecoration(
        gradient:
            /* disable
            ? (disGradient ?? appColors.disableGradient)
            : */
            (gradient ?? appColors.primaryGradient),
        borderRadius: borderRadius ?? BorderRadius.circular(4),
        // color: disable ? disableColor ?? appColors.textColor4 : null,
      ),
      child: FlatButton(
        padding: padding ?? EdgeInsets.zero,
        onPressed: onPressed,
        height: buttonHeight,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(4),
        ),
        child: Text(
          text ?? '',
          style: buttonTextStyle,
          // textAlign: TextAlign.justify,
        ),
      ),
    );

    //，50%
    if (disable) {
      child = AnimatedOpacity(
        opacity: 0.5,
        duration: const Duration(milliseconds: 100),
        child: child,
      );
    }

    return child;
  }
}

///
class SecondaryButton extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? textColor;
  final Color? disableColor;
  final BorderRadius? borderRadius;
  final double width;
  final double height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;

  const SecondaryButton({
    Key? key,
    this.text,
    this.style,
    this.onPressed,
    this.color,
    this.textColor,
    this.disableColor,
    this.borderRadius,
    this.width = 0,
    this.height = 44.0,
    this.constraints,
    this.padding,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    final appColors = AppTheme.of(context).currentColors;
    final buttonTextStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16,
    ).merge(style);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonHeight = height;
    Color buttonColor;

    if (onPressed == null) {
      buttonColor = disableColor ?? appColors.textColor4;
    } else {
      buttonColor = color ??
          (isDark
              ? appColors.textColor4
              : Theme.of(context).accentColor.withOpacity(0.1));
    }

    var buttonTextColor = textColor;

    if (null == buttonTextColor) {
      buttonTextColor =
          isDark ? appColors.textColor1 : Theme.of(context).accentColor;
    }

    return SizedBox(
      width: width,
      child: FlatButton(
        highlightColor: Colors.white10,
        onPressed: onPressed,
        // minWidth: width ?? double.maxFinite,
        height: buttonHeight,
        textColor: buttonTextColor,
        padding: padding ?? EdgeInsets.zero,
        color: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (null != icon) icon?? const SizedBox(width: 10,),
            Text(
              text ?? '',
              style: buttonTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
