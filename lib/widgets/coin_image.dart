import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/generated/assets.dart';

///. 
/// [icon]    
/// [radius]  
class CoinImage extends StatelessWidget {
  final String icon;
  final double radius;

  const CoinImage({Key? key, required this.icon, this.radius = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = radius * 2;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    //
    final loadFailedIcon = service.image.asset(
      isDark
          ? Assets.assets_image_coin_unknown_dark_png
          : Assets.assets_image_coin_unknown_light_png,
      width: width,
      height: width,
    );
    //
    final loadingIcon = service.svg.asset(
      isDark ? Assets.assets_svg_coin_slope_dark_svg : Assets.assets_svg_coin_slope_light_svg,
      width: width,
      height: width,
    );
    Widget iconImage;
    if (icon.trim().isEmpty) {
      iconImage = loadFailedIcon;
    } else {
      iconImage = isNetworkUrl(icon)
          ? buildNetWorkImage(icon, width, loadFailedIcon, loadingIcon)
          : ExtendedImage.asset(
              icon,
              width: width,
              height: width,
              fit: BoxFit.cover,
              loadStateChanged: (state) {
                if (state.extendedImageLoadState == LoadState.loading)
                  return loadingIcon;
                if (state.extendedImageLoadState == LoadState.failed)
                  return loadFailedIcon;
                return null;
              },
            );
    }

    return ClipRRect(
      child: iconImage,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  Widget buildNetWorkImage(String icon, double width, Widget loadFailedIcon, Widget loadingIcon) {
    if (icon.endsWith(".svg")) {
      return service.svg.network(
        icon,
        width: width,
        height: width,
        fit: BoxFit.cover,
        placeholderWidget: loadFailedIcon,
      );
    } else {
      return service.image.network(
        icon,
        width: width,
        height: width,
        loadFailedWidget: loadFailedIcon,
        loadingWidget: loadingIcon,
        fit: BoxFit.cover,
      );
    }
  }
}
