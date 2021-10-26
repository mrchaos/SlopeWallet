import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';


enum LoadingState {
  loading,
  error,
  ok,
}

/// Dialog
///
/// *[barrierColor]
/// *[barrierDismissible]
/// *[message]
/// *[showMessage]
/// *[loadingState]  ，[LoadingState.loading] : ，[LoadingState.ok] : ，[LoadingState.error] :
Future showLoadingDialog({
  required BuildContext context,
  Color barrierColor = Colors.transparent,
  bool barrierDismissible = true,
  String? message,
  bool showMessage = true,
  LoadingState loadingState = LoadingState.loading,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (c) => WillPopScope(
      onWillPop: () => Future.value(barrierDismissible),
      child: SimpleDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0,
        children: [
          LoadStatusWidget(
            message: message,
            showMessage: showMessage,
            loadingState: loadingState,
          ),
        ],
      ),
    ),

    // barrierColor: barrierColor ?? const Color(0x66000000),
    barrierColor: barrierColor,
  );
}

const _kLoadingIconSize = 32.0;

class LoadStatusWidget extends StatelessWidget {
  final String? message;
  final bool showMessage;

  final LoadingState loadingState;

  const LoadStatusWidget(
      {Key? key,
      this.message,
      this.showMessage = true,
      this.loadingState = LoadingState.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final dark = themeData.brightness == Brightness.dark;

    return UnconstrainedBox(
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(minWidth: 82, minHeight: 86),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: ShapeDecoration(
          color: dark ? const Color(0xFF464C58) : const Color(0xFFE6E6E6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Builder(builder: (context) {
          Widget? icon;
          String? label = message;

          switch (loadingState) {
            case LoadingState.ok:
              {
                icon = service.image.asset(Assets.assets_image_ic_loading_ok_light_png,
                  width: _kLoadingIconSize,
                  height: _kLoadingIconSize,
                  color: themeData.iconTheme.color,
                );
                label ??= 'success';
              }
              break;
            case LoadingState.error:
              {
                icon = service.image.asset(
                  Assets.assets_svg_img_load_error_svg,
                  width: _kLoadingIconSize,
                  height: _kLoadingIconSize,
                  color: themeData.iconTheme.color,
                );
                label ??= 'failure';
              }
              break;
            case LoadingState.loading:
              {
                icon = const LoadingWidget();
                label ??= 'loading...';
              }
              break;
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              icon,
              SizedBox(height: showMessage ? 10 : 16),
              if (showMessage)
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500),
                  strutStyle:
                      StrutStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              if (showMessage) const SizedBox(height: 16),
            ],
          );
        }),
      ),
    );
  }
}

///：
class LoadingWidget extends StatefulWidget {
  final double? size;

  const LoadingWidget({Key? key, this.size}) : super(key: key);

  @override
  __LoadingAnimatedState createState() => __LoadingAnimatedState();
}

class __LoadingAnimatedState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final image = Assets.assets_image_ic_loading_light_png;
    return AnimatedBuilder(
      animation: _controller,
      child: service.image.asset(
        image,
        width: widget.size ?? _kLoadingIconSize,
        height: widget.size ?? _kLoadingIconSize,
        fit: BoxFit.scaleDown,
      ),
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: -_controller.value * 2.0 * pi,
          child: child,
        );
      },
    );
  }
}
