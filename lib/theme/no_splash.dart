import 'package:flutter/material.dart';

class NoSplashFactory extends InteractiveInkFeatureFactory {
  InteractiveInkFeature create(
      {required MaterialInkController controller,
      required RenderBox referenceBox,
      required Color color,
      Offset? position,
      TextDirection? textDirection,
      bool containedInkWell = false,
      rectCallback,
      BorderRadius? borderRadius,
      ShapeBorder? customBorder,
      double? radius,
      onRemoved}) {
    return _NoInteractiveInkFeature(
        controller: controller, referenceBox: referenceBox, color: color);
  }
}

class _NoInteractiveInkFeature extends InteractiveInkFeature {
  _NoInteractiveInkFeature({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Color color,
  }) : super(controller: controller, referenceBox: referenceBox, color: color);

  void paintFeature(Canvas canvas, Matrix4 transform) {}
}
