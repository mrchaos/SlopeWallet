import 'package:flutter/cupertino.dart';

class IndicatorBase extends Decoration {
  final BoxPainter painter;

  IndicatorBase({required this.painter});

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is IndicatorBase) {
      return IndicatorBase(painter: this.painter);
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is IndicatorBase) {
      return IndicatorBase(painter: this.painter);
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return this.painter;
  }
}
