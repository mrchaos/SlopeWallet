import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';

class LoadNetWorkImage extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final double radius;
  final BoxFit? fit;

  const LoadNetWorkImage(
      {Key? key,
      required this.width,
      required this.height,
      this.url = '',
      this.fit,
      this.radius = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    var loadImage = isDark
        ? service.image.asset(Assets.assets_image_dark_browser_not_url_png)
        : service.image.asset(Assets.assets_image_light_browser_not_url_png);
    var image = service.image.network(url,
        width: width,
        height: height,
        loadFailedWidget: loadImage,
        loadingWidget: loadImage,
        fit: fit);
    return ClipRRect(
      child: image,
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
