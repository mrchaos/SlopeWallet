import 'package:flutter/material.dart';

const kRadius = 2.0;

const _kBorderRadius = BorderRadius.all(Radius.circular(kRadius));

Widget getPlaceholder(double? width, double? height,
    [double? radius, Color? color]) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius:
          radius != null ? BorderRadius.circular(radius) : _kBorderRadius,
      color: color ?? const Color(0xFFF7F8FA),
    ),
  );
}

class AnimationHolder extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;

  const AnimationHolder(
      {Key? key, this.width, this.height, this.radius = kRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationHolderBuilder(
      builder: (_) => getPlaceholder(width, height, radius),
    );
  }
}

class AnimationHolderBuilder extends StatefulWidget {
  final WidgetBuilder? builder;

  const AnimationHolderBuilder({Key? key, this.builder}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimationHolderState();
}

class _AnimationHolderState extends State<AnimationHolderBuilder>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      lowerBound: 0.4,
      upperBound: 1.0,
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      child: widget.builder?.call(context),
      builder: (c, child) => AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: _controller!.value,
        child: child,
      ),
    );
  }
}
