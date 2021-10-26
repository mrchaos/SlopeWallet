import 'dart:async';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_home_banner_bean.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/alumni/news/alumni_news_model.dart';
import 'package:wallet/theme/app_colors.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/list_placeholder.dart';
import 'package:wd_common_package/wd_common_package.dart';

///
class BannerPage extends StatefulWidget {
  final List<ImageProvider> images;
  final Duration playDuration;
  final void Function(int value)? onTapBanner;
  final bool autoPlay;
  final EdgeInsetsGeometry? pageMargin;
  final BorderRadius? borderRadius;
  final NullableIndexedWidgetBuilder? builder;
  final int _buildCount;
  final bool showIndicator;
  final List<AlumniNewsBannerBean> alumniNewsBanner;

  const BannerPage(
      {Key? key,
      this.images = const <ImageProvider>[],
      this.playDuration = const Duration(seconds: 5),
      this.onTapBanner,
      this.autoPlay = true,
      this.pageMargin,
      this.borderRadius,
      this.showIndicator = true,
      this.alumniNewsBanner = const []})
      : this.builder = null,
        this._buildCount = images.length,
        super(key: key);

  BannerPage.url(
      {Key? key,
      List<String> imageUrls = const <String>[],
      this.playDuration = const Duration(seconds: 5),
      this.onTapBanner,
      this.autoPlay = true,
      this.pageMargin,
      this.borderRadius,
      this.showIndicator = true,
      this.alumniNewsBanner = const []})
      : images =
            imageUrls.map((e) => ExtendedResizeImage(NetworkImage(e))).toList(),
        this.builder = null,
        this._buildCount = imageUrls.length,
        //
        // images = ([
        //   'https://img.zcool.cn/community/01cfa75cdbaf02a801214168d5a68d.jpg',
        //   'https://pic.macw.com/pic/202002/17163720_e2bb6a15c2.jpeg',
        //   'https://tse4-mm.cn.bing.net/th/id/OIP.Le46HfnZgiYrqAick1T_xwHaD6?pid=Api&rs=1',
        // ]).map((e) => NetworkImage(e)).toList(),
        super(key: key);

  const BannerPage.builder(
      {Key? key,
      required this.builder,
      this.autoPlay = true,
      required int itemCount,
      this.playDuration = const Duration(seconds: 5),
      this.onTapBanner,
      this.pageMargin,
      this.borderRadius,
      this.showIndicator = true,
      this.alumniNewsBanner = const []})
      : images = const [],
        this._buildCount = itemCount,
        super(key: key);

  @override
  _BannerState createState() => _BannerState();
}

class _BannerState extends State<BannerPage> {
  Timer? timer;

  int currentIndex = 0;

  PageController? controller;

  ValueNotifier<int>? pageIndexNotifier;
  final GlobalKey _pageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    currentIndex = widget.images.length * 100;
    controller = PageController(initialPage: currentIndex);
    pageIndexNotifier = ValueNotifier(currentIndex);
    if (widget.showIndicator) createTimer();
  }

  int? _timerNextIndex;

  void createTimer() {
    timer?.cancel();
    if (!widget.autoPlay) return;
    timer = Timer.periodic(widget.playDuration, (timer) {
      var findRenderObject = _pageKey.currentContext?.findRenderObject();
      if (findRenderObject is RenderBox && !findRenderObject.isShowOnScreen) {
        return;
      }

      if (controller?.hasClients ?? false) {
        _timerNextIndex = currentIndex + 1;
        controller?.animateToPage(_timerNextIndex!,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
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

    logger.d('currentIndex:${currentIndex % 3}');

    return Column(
      children: [
        if (widget._buildCount < 1)
          Padding(
            padding: widget.pageMargin ?? EdgeInsets.zero,
            child: AnimationHolder(height: double.maxFinite, radius: 8),
          ),
        if (widget._buildCount > 0)
          Container(
            height: 188,
            child: PageView.builder(
              key: _pageKey,
              controller: controller,
              physics: widget._buildCount < 2
                  ? NeverScrollableScrollPhysics()
                  : null,
              onPageChanged: (index) {
                //，
                if (_timerNextIndex != null && _timerNextIndex! - 1 != index) {
                  createTimer();
                }
                currentIndex = index;
                pageIndexNotifier?.value = currentIndex;
              },
              itemBuilder: (context, index) {
                int _count = index % widget._buildCount;
                return GestureDetector(
                onTap: () {
                  if (widget.images.isNotEmpty && widget.onTapBanner != null) {
                    widget.onTapBanner!(index % widget.images.length);
                  }
                },
                child: Container(
                  margin: widget.pageMargin,
                  child: ClipRRect(
                    borderRadius:
                        widget.borderRadius ?? BorderRadius.circular(0),
                    child: widget.builder != null
                        ? widget.builder!(
                                context, _count) ??
                            const SizedBox()
                        : Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image(
                                height: 188,
                                width: double.infinity,
                                image:
                                    widget.images[_count],
                                fit: BoxFit.fill,
                                loadingBuilder: (c, child, event) {
                                  if (event == null) return child;
                                  return imageLoading;
                                },
                                errorBuilder: (c, e, s) => imageErrorWidget,
                              ),
                              if (widget.alumniNewsBanner[_count].newTitle != null) _buildClipRect(_count),
                            ],
                          ),
                  ),
                ),
              );
              },
            ),
          ),
        SizedBox(
          height: 8,
        ),
        if (widget.showIndicator)
          ValueListenableBuilder<int>(
            valueListenable: pageIndexNotifier!,
            builder: (c, index, child) => PageIndicator(
                itemCount: itemCount,
                currentIndex: itemCount == 0 ? 0 : index % itemCount),
          ),
      ],
    );
  }

  /// ； ClipRect
  ClipRect _buildClipRect(int index) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: 98,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff000000).withOpacity(0),
                Color(0xff000000).withOpacity(0.4),
              ],
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Text(
            '${widget.alumniNewsBanner[index].newTitle ?? ""}',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 22 / 16,
            ),
          ),
          // child: Color(),
        ),
      ),
    );
  }

  int get itemCount {
    int count;
    if (widget.builder != null) {
      count = widget._buildCount;
    } else {
      count = widget.images.isEmpty ? 1 : widget.images.length;
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

class PageIndicator extends StatefulWidget {
  final int itemCount;
  final int currentIndex;

  const PageIndicator(
      {Key? key, required this.itemCount, required this.currentIndex})
      : super(key: key);

  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  AppColors get appColors => AppTheme.of(context).currentColors;
  @override
  Widget build(BuildContext context) {
    double width = (widget.itemCount - 1) * 4 + widget.itemCount * 3;

    return Container(
      width: width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...List.generate(
              widget.itemCount,
              (index) => ClipOval(
                    child: Container(
                      width: 3,
                      height: 3,
                      color: widget.currentIndex == index
                          ? appColors.newsBannerPointerActiveColor
                          : appColors.newsBannerPointerColor,
                    ),
                  ))
        ],
      ),
    );
  }
}
