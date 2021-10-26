import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TabIndicator extends Decoration {
  final double indicatorWidth;
  final double indicatorHeight;
  final List<Color> indicatorColors;

  final BorderRadius lineRadius;
  final EdgeInsets insets;

  const TabIndicator({
    this.indicatorWidth = 16.0,
    this.indicatorHeight = 4.0,
    this.indicatorColors = const [Color(0xFFFF4D58), Color(0xFFFF6A4D)],
    this.lineRadius = const BorderRadius.all(Radius.circular(2)),
    this.insets = EdgeInsets.zero,
  });

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is TabIndicator) {
      return TabIndicator(
        indicatorColors: a.indicatorColors,
        indicatorWidth: a.indicatorWidth,
        indicatorHeight: a.indicatorHeight,
        lineRadius: a.lineRadius,
        insets: a.insets,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is TabIndicator) {
      return TabIndicator(
        indicatorColors: b.indicatorColors,
        indicatorWidth: b.indicatorWidth,
        indicatorHeight: b.indicatorHeight,
        lineRadius: b.lineRadius,
        insets: b.insets,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _UnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this, onChanged);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    final indicatorRect = Rect.fromCenter(
        center: indicator.bottomCenter,
        width: min(indicatorWidth, indicator.width),
        height: min(indicatorHeight, indicator.height));
    return indicatorRect;
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final TabIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset.translate(0, -decoration.indicatorHeight / 2) &
        configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    final Rect indicator = decoration._indicatorRectFor(rect, textDirection);
    final Paint paint = Paint();

    if (decoration.indicatorColors.length > 1) {
      paint.shader = LinearGradient(
        colors: decoration.indicatorColors,
      ).createShader(rect);
    } else if (decoration.indicatorColors.isNotEmpty) {
      paint.color = decoration.indicatorColors.first;
    }

    final rRect = decoration.lineRadius.toRRect(indicator);
    canvas.drawRRect(rRect, paint);
  }
}
