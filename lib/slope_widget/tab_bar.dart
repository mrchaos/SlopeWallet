import 'package:flutter/material.dart';
import 'package:wallet/theme/app_theme.dart';

const kSlopeTabBarHeight = 40.0;
const _kItemSpace = 16.0;

/// * [labels] 
/// * [initialIndex] 
/// * [margin] 
/// * [padding] 
/// * [actions] 
/// * [onTap] 
/// * [controller] 
/// * [labelStyle] 
/// * [unselectedLabelStyle]  
/// * [height] TabBar.40.0
/// * [itemSpace] . 16.0
class SlopeTabBar extends StatelessWidget {
  final List<String> labels;
  final int initialIndex;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final List<Widget> actions;
  final ValueChanged<int>? onTap;
  final TabController? controller;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final double? height;
  final double? itemSpace;

  const SlopeTabBar({
    Key? key,
    required this.labels,
    this.controller,
    this.initialIndex = 0,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.actions = const [],
    this.onTap,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.height = kSlopeTabBarHeight,
    this.itemSpace = _kItemSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tabBarHeight = height ?? kSlopeTabBarHeight;
    final _itemSpace = itemSpace ?? _kItemSpace;
    final _unselectedLabelStyle =
        (TabBarTheme.of(context).unselectedLabelStyle ?? const TextStyle())
            .merge(TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: context.appColors.textColor3,
            ))
            .merge(unselectedLabelStyle);
    final _selectedLabelStyle = (TabBarTheme.of(context).labelStyle ?? const TextStyle())
        .merge(TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: context.appColors.textColor1,
        ))
        .merge(labelStyle);
    var container = Container(
      padding: padding,
      margin: margin,
      height: _tabBarHeight,
      alignment: Alignment.centerLeft,
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TabBar(
                  controller: controller,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelPadding: EdgeInsets.zero,
                  indicator: const BoxDecoration(),
                  indicatorWeight: 0,
                  labelColor: _selectedLabelStyle.color,
                  labelStyle: _selectedLabelStyle,
                  unselectedLabelColor: _unselectedLabelStyle.color,
                  unselectedLabelStyle: _unselectedLabelStyle,
                  onTap: onTap,
                  tabs: [
                    for (var i = 0; i < labels.length; i++)
                      Container(
                        child: Text(labels[i]),
                        margin: i >= labels.length - 1
                            ? EdgeInsets.zero
                            : EdgeInsets.only(right: _itemSpace),
                        constraints: BoxConstraints.tightFor(height: _tabBarHeight),
                        alignment: Alignment.center,
                      ),
                  ]),
            ),
            //right actions
            if (actions.isNotEmpty) ...actions,
          ],
        ),
      ),
    );

    if (controller == null) {
      return DefaultTabController(
        length: labels.length,
        child: container,
      );
    }
    return container;
  }
}

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget child;
  final Color? backgroundColor;

  const StickyHeaderDelegate({
    required this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: child,
    );
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(StickyHeaderDelegate oldDelegate) {
    return child != oldDelegate.child || backgroundColor != oldDelegate.backgroundColor;
  }
}
