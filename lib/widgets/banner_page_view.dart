import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/widgets/list_placeholder.dart';

/// .
/// ，
class BannerPageView extends StatefulWidget {
  final List<ImageProvider> images;
  final Duration playDuration;
  final bool autoPlay;
  final void Function(int value)? onTapBanner;
  final EdgeInsetsGeometry? pageMargin;
  final BorderRadius? borderRadius;
  final NullableIndexedWidgetBuilder? builder;
  final int _buildCount;
  final bool showIndicator;

  const BannerPageView({
    Key? key,
    this.images = const <ImageProvider>[],
    this.playDuration = const Duration(seconds: 5),
    this.autoPlay = true,
    this.onTapBanner,
    this.pageMargin,
    this.borderRadius,
    this.showIndicator = true,
  })  : this.builder = null,
        this._buildCount = images.length,
        super(key: key);

  BannerPageView.url({
    Key? key,
    List<String> imageUrls = const <String>[],
    this.playDuration = const Duration(seconds: 5),
    this.autoPlay = true,
    this.onTapBanner,
    this.pageMargin,
    this.borderRadius,
    this.showIndicator = true,
  })  : images = imageUrls
            .map((e) =>
                ExtendedResizeImage.resizeIfNeeded(provider: ExtendedNetworkImageProvider(e, cache: true)))
            .toList(),
        this.builder = null,
        this._buildCount = imageUrls.length,
        //
        // images = ([
        //   'https://img.zcool.cn/community/01cfa75cdbaf02a801214168d5a68d.jpg',
        //   'https://pic.macw.com/pic/202002/17163720_e2bb6a15c2.jpeg',
        //   'https://tse4-mm.cn.bing.net/th/id/OIP.Le46HfnZgiYrqAick1T_xwHaD6?pid=Api&rs=1',
        // ]).map((e) => NetworkImage(e)).toList(),
        super(key: key);

  const BannerPageView.builder({
    Key? key,
    required this.builder,
    required int itemCount,
    this.playDuration = const Duration(seconds: 5),
    this.autoPlay = true,
    this.onTapBanner,
    this.pageMargin,
    this.borderRadius,
    this.showIndicator = true,
  })  : images = const [],
        this._buildCount = itemCount,
        super(key: key);

  @override
  _BannerState createState() => _BannerState();
}

const _kBannerLoopMaxSize = 50;

class _BannerState extends State<BannerPageView> {
  Timer? timer;

  int currentIndex = 0;
  late PageController controller;

  ValueNotifier<int>? pageIndexNotifier;
  final GlobalKey _pageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    if (itemCount > 1) {
      currentIndex = itemCount * min(_kBannerLoopMaxSize, 2);
    }
    controller = PageController(initialPage: currentIndex);
    pageIndexNotifier = ValueNotifier(currentIndex);
    createTimer();
  }

  @override
  void didUpdateWidget(covariant BannerPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
  }

  int? _timerNextIndex;

  void createTimer() {
    if (itemCount < 2) return;
    timer?.cancel();
    if (!widget.autoPlay) return;
    timer = Timer.periodic(widget.playDuration, (timer) {
      var findRenderObject = _pageKey.currentContext?.findRenderObject();
      if (findRenderObject is RenderBox && !findRenderObject.isShowOnScreen) {
        return;
      }

      if (controller.hasClients) {
        bool reset = (currentIndex + 1) == (itemCount * _kBannerLoopMaxSize);
        _timerNextIndex = (currentIndex + 1) % (itemCount * _kBannerLoopMaxSize);
        controller.animateToPage(
          _timerNextIndex!,
          duration: reset ? const Duration(milliseconds: 1) : const Duration(milliseconds: 300),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    timer = null;
    pageIndexNotifier?.dispose();
    pageIndexNotifier = null;
  }

  Widget get imageLoading {
    return AnimationHolderBuilder(
      builder: (_) => getPlaceholder(double.maxFinite, double.maxFinite),
    );
  }

  @override
  Widget build(BuildContext context) {
    final indicatorWidth = 8.0 * itemCount;
    const indicatorBackgroundColor = Color.fromRGBO(255, 255, 255, 0.5);
    const indicatorColor = Colors.white;
    var dark = Theme.of(context).brightness == Brightness.dark;
    final imageErrorWidget = Stack(
      alignment: Alignment.center,
      children: [
        getPlaceholder(double.maxFinite, double.maxFinite),
        SvgPicture.asset(
          Assets.assets_svg_img_load_error_svg,
          color: dark ? const Color(0xFF323947) : const Color(0xFFE1E2E5),
        ),
      ],
    );

    return Stack(
      children: [
        if (itemCount < 1)
          Padding(
            padding: widget.pageMargin ?? EdgeInsets.zero,
            child: AnimationHolder(
              width: double.maxFinite,
              height: double.maxFinite,
              radius: 8,
            ),
          ),
        if (itemCount > 0)
          PageView.builder(
            key: _pageKey,
            controller: controller,
            physics: itemCount > 1 ? null : const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              //，
              if (_timerNextIndex != null && _timerNextIndex! - 1 != index) {
                createTimer();
              }
              currentIndex = index;
              pageIndexNotifier?.value = currentIndex;
            },
            itemCount: itemCount > 1 ? null : 1,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                if (widget.images.isNotEmpty && widget.onTapBanner != null) {
                  widget.onTapBanner!(index % itemCount);
                }
              },
              child: Container(
                margin: widget.pageMargin,
                child: ClipRRect(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
                  child: widget.builder != null
                      ? widget.builder!(context, index % itemCount) ?? const SizedBox()
                      : Image(
                          image: widget.images[index % itemCount],
                          fit: BoxFit.cover,
                          loadingBuilder: (c, child, event) {
                            if (event == null) return child;
                            return imageLoading;
                          },
                          errorBuilder: (c, e, s) => imageErrorWidget,
                        ),
                ),
              ),
            ),
          ),
        if (widget.showIndicator && itemCount > 1)
          ValueListenableBuilder<int>(
            valueListenable: pageIndexNotifier!,
            builder: (c, index, child) => Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                child: _PageIndicator(
                  currentIndex: itemCount == 0 ? 0 : index % itemCount,
                  count: itemCount,
                  indicatorColor: indicatorColor,
                  backgroundColor: indicatorBackgroundColor,
                  minHeight: 2,
                ),
                width: indicatorWidth,
              ),
            ),
          ),
      ],
    );
  }

  ///
  int get itemCount {
    int count;
    if (widget.builder != null) {
      count = widget._buildCount;
    } else {
      count = widget.images.length;
    }
    return count;
  }
}

extension _RenderBoxExt on RenderBox? {
  ///
  bool get isShowOnScreen {
    final offset = this?.localToGlobal(Offset.zero);
    if (offset?.dx.toString() == double.nan.toString() ||
        offset?.dy.toString() == double.nan.toString()) {
      return false;
    }
    return true;
  }
}

typedef ValueIndicatorBuilder = Widget Function(double value);

///
/// Page
/// * [count]
/// * [minHeight]
/// * [currentIndex] ,  [currentIndex] <= [count]
/// * [backgroundColor]
/// * [indicatorColor]
/// * [radius]
class _PageIndicator extends StatelessWidget {
  final double minHeight;
  final int count;
  final int currentIndex;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final Radius? radius;

  _PageIndicator({
    Key? key,
    this.count = 1,
    this.currentIndex = 0,
    this.backgroundColor,
    this.indicatorColor,
    this.minHeight = 2.0,
    this.radius,
  })  : assert(count >= 1),
        super(key: key);

  Color _getBackgroundColor(BuildContext context) =>
      backgroundColor ?? Theme.of(context).backgroundColor;

  Color _getIndicatorColor(BuildContext context) {
    return indicatorColor ?? Theme.of(context).accentColor;
  }

  @override
  Widget build(BuildContext context) {
    final painter = _IndicatorPainter(
      backgroundColor: _getBackgroundColor(context),
      indicatorColor: _getIndicatorColor(context),
      currentIndex: currentIndex,
      count: count,
      radius: radius,
    );
    var widget = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: minHeight,
      ),
      child: CustomPaint(painter: painter),
    );

    return widget;
  }
}

class _IndicatorPainter extends CustomPainter {
  const _IndicatorPainter({
    required this.currentIndex,
    required this.count,
    this.radius,
    this.backgroundColor,
    this.indicatorColor,
  });

  final int count;
  final int currentIndex;
  final Radius? radius;
  final Color? backgroundColor;
  final Color? indicatorColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backgroundColor!
      ..style = PaintingStyle.fill;

    final barRadius = radius ?? Radius.circular(size.height / 2);
    final backgroundRRect = RRect.fromRectAndRadius(Offset.zero & size, barRadius);
    canvas.drawRRect(backgroundRRect, paint);

    paint.color = indicatorColor!;

    void drawIndicator(double x, double width) {
      if (width <= 0.0) return;
      double left = x;
      final valueRRect =
          RRect.fromRectAndRadius(Offset(left, 0.0) & Size(width, size.height), barRadius);

      canvas.drawRRect(valueRRect, paint);
    }

    final indicatorWidth = size.width / count;
    // debugPrint('indicatorWidth=$indicatorWidth currentIndex=$currentIndex');
    drawIndicator(indicatorWidth * currentIndex, indicatorWidth);
  }

  @override
  bool shouldRepaint(_IndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.indicatorColor != indicatorColor ||
        oldPainter.currentIndex != currentIndex ||
        oldPainter.radius != radius ||
        oldPainter.count != count;
  }
}
