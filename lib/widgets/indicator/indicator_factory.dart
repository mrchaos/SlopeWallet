import 'dart:math';

import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/widgets/indicator/indicator_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndicatorFactory {

  static Decoration none() => IndicatorBase(painter: NoIndicatorPainter());

  static Decoration line({
    Size? indicatorSize = const Size(16, 4),
    Color? indicatorColor,
    BorderRadius? indicatorRadius = const BorderRadius.all(Radius.circular(2)),
    EdgeInsets? insets = EdgeInsets.zero,
    List<Color>? gradientColors,
  }) =>
      IndicatorBase(painter: LineIndicatorPainter(
        indicatorColor: indicatorColor,
        indicatorRadius: indicatorRadius,
        indicatorSize: indicatorSize!,
        insets: insets,
        gradientColors: gradientColors,
      ));
}

class NoIndicatorPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    canvas.drawRect(Rect.zero, Paint());
  }
}

class LineIndicatorPainter extends BoxPainter {
  final Size indicatorSize;
  final Color? indicatorColor;
  final BorderRadius? indicatorRadius;
  final EdgeInsets? insets;
  final List<Color>? gradientColors;

  LineIndicatorPainter({
    required this.indicatorSize ,
    this.indicatorColor,
    this.indicatorRadius,
    this.insets,
    this.gradientColors,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final TextDirection textDirection = configuration.textDirection!;
    final Rect rect = offset & configuration.size!;
    /// insetrect
    final Rect rectWithoutInset =
    insets!.resolve(textDirection).deflateRect(rect);
    /// indicatorsize
    final double indicatorLeft = rectWithoutInset.left +
        (rectWithoutInset.width - indicatorSize.width) * 0.5;
    final double indicatorTop = rectWithoutInset.bottom - indicatorSize.height;
    final Rect indicator = Rect.fromLTWH(indicatorLeft, indicatorTop,
        indicatorSize.width, indicatorSize.height);
    ///
    final Paint paint = Paint();
    if (null != gradientColors && gradientColors!.length > 1) {
      paint.shader = LinearGradient(
        colors: gradientColors!,
      ).createShader(rect);
    } else {
      Color pc = indicatorColor ??
          Theme.of(service.router.appContext).indicatorColor;
      paint.color = pc;
    }
    final RRect rRect = indicatorRadius!.toRRect(indicator);
    canvas.drawRRect(rRect, paint);
  }
}
