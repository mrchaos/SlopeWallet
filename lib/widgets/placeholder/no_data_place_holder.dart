import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';

/// 
class NoDataPlaceHolder extends StatelessWidget {
  const NoDataPlaceHolder({
    Key? key,
    this.margin,
    this.textMargin,
    this.text = 'No record',
    this.textStyle,
    this.image,
    this.alignment = Alignment.center,
  }) : super(key: key);

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? textMargin;
  final Widget? image;
  final String? text;
  final TextStyle? textStyle;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (null != image) image!,
          if (null == image)
            service.image.asset(
              context.isLightTheme
                  ? Assets.assets_image_img_no_datas_light_png
                  : Assets.assets_image_img_no_datas_dark_png,
              fit: BoxFit.fill,
              width: 223,
              height: 223,
            ),
          Container(
            margin: textMargin ??
                const EdgeInsets.only(
                  top: 0,
                ),
            child: Text(
              text ?? '',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 18 / 14,
                color: context.appColors.textColor1,
              ).merge(textStyle),
            ),
          )
        ],
      ),
    );
  }
}
