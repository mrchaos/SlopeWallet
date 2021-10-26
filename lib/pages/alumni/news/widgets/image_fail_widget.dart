
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';

class ImageFailWidget extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final double radius;

  const ImageFailWidget({Key? key, required this.width, required this.height, this.url = '', this.radius = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;
    // var loadImage =isDark?
    // service.image.asset(Assets.assets_image_dark_browser_not_url_png):
    // service.image.asset(Assets.assets_image_light_browser_not_url_png);
    AppColors appColor = AppTheme.of(context).currentColors;
   Widget filedAndLoadWidget = Container(
      width: width,
      height: height,
      color: appColor.backgroundColor,
    );
    var Image = service.image.network(
      url,
      width:width,
      height: height,
      loadFailedWidget:filedAndLoadWidget,
      loadingWidget: filedAndLoadWidget,
      fit: BoxFit.cover
    );
    return ClipRRect(
      child: Image,
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
