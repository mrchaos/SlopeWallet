// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:math';
import 'dart:ui' show window;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const Duration _kDropdownMenuDuration = Duration(milliseconds: 300);
const EdgeInsets _kMenuMargin = EdgeInsets.symmetric(horizontal: 16);

typedef DropdownButtonBuilder = List<Widget> Function(BuildContext context);

class _DropdownMenuPainter extends CustomPainter {
  _DropdownMenuPainter({
    this.color,
    this.dropdownBarrierColor,
    this.elevation,
    this.selectedIndex,
    this.resize,
    this.getSelectedItemOffset,
    this.mediaQueryData,
    this.borderRadius,
  })  : _painter = BoxDecoration(
          // If you add an image here, you must provide a real
          // configuration in the paint() function and you must provide some sort
          // of onChanged callback here.
          color: color,
          borderRadius:
              borderRadius ?? BorderRadius.vertical(bottom: Radius.circular(8)),
          boxShadow: kElevationToShadow[elevation!],
        ).createBoxPainter(),
        super(repaint: resize);

  final Color? color;
  final Color? dropdownBarrierColor;
  final int? elevation;
  final int? selectedIndex;
  final Animation<double>? resize;
  final ValueGetter<double>? getSelectedItemOffset;
  final BoxPainter _painter;
  final MediaQueryData? mediaQueryData;
  final BorderRadius? borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final double selectedItemOffset = getSelectedItemOffset!();

    if (dropdownBarrierColor != null) {
      canvas.drawRect(
          Rect.fromLTWH(
              0, selectedItemOffset, size.width, mediaQueryData!.size.height),
          Paint()..color = dropdownBarrierColor!);
    }

    final Tween<double> top = Tween<double>(
      begin: selectedItemOffset.clamp(0.0, max(0.0, size.height)) as double,
      end: 0.0,
    );

    final Tween<double> bottom = Tween<double>(
      begin: top.begin!.clamp(0, size.height) as double,
      end: size.height,
    );

    final Rect rect = Rect.fromLTRB(
        0.0, top.evaluate(resize!), size.width, bottom.evaluate(resize!));

    _painter.paint(canvas, rect.topLeft, ImageConfiguration(size: rect.size));
  }

  @override
  bool shouldRepaint(_DropdownMenuPainter oldPainter) {
    return oldPainter.color != color ||
        oldPainter.elevation != elevation ||
        oldPainter.selectedIndex != selectedIndex ||
        oldPainter.resize != resize;
  }
}

// Do not use the platform-specific default scroll configuration.
// Dropdown menus should never overscroll or display an overscroll indicator.
class _DropdownScrollBehavior extends ScrollBehavior {
  const _DropdownScrollBehavior();

  @override
  TargetPlatform getPlatform(BuildContext context) =>
      Theme.of(context).platform;

  @override
  Widget buildViewportChrome(
          BuildContext context, Widget child, AxisDirection axisDirection) =>
      child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}

// The widget that is the button wrapping the menu items.
class _DropdownMenuItemButton<T> extends StatefulWidget {
  const _DropdownMenuItemButton({
    Key? key,
    required this.padding,
    required this.route,
    required this.buttonRect,
    required this.constraints,
    required this.itemIndex,
    this.itemSpacing,
  }) : super(key: key);

  final _DropdownRoute<T> route;
  final EdgeInsets? padding;
  final Rect? buttonRect;
  final BoxConstraints? constraints;
  final int itemIndex;
  final double? itemSpacing;

  @override
  _DropdownMenuItemButtonState<T> createState() =>
      _DropdownMenuItemButtonState<T>();
}

class _DropdownMenuItemButtonState<T>
    extends State<_DropdownMenuItemButton<T>> {
  void _handleFocusChange(bool focused) {
    late bool inTraditionalMode;
    switch (FocusManager.instance.highlightMode) {
      case FocusHighlightMode.touch:
        inTraditionalMode = false;
        break;
      case FocusHighlightMode.traditional:
        inTraditionalMode = true;
        break;
    }

    if (focused && inTraditionalMode) {
      final _MenuLimits menuLimits = widget.route.getMenuLimits(
          widget.buttonRect!, widget.constraints!.maxHeight, widget.itemIndex);
      widget.route.scrollController!.animateTo(
        menuLimits.scrollOffset,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 100),
      );
    }
  }

  void _handleOnTap() {
    final DropdownMenuItem<T> dropdownMenuItem =
        widget.route.items[widget.itemIndex].item;

    if (dropdownMenuItem.onTap != null) {
      dropdownMenuItem.onTap!();
    }

    Navigator.pop(
      context,
      _DropdownRouteResult<T>(dropdownMenuItem.value!),
    );
  }

  static final Map<LogicalKeySet, Intent> _webShortcuts =
      <LogicalKeySet, Intent>{
    LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
  };

  @override
  Widget build(BuildContext context) {
    CurvedAnimation opacity;
    final double unit = 0.5 / (widget.route.items.length + 1.5);
    if (widget.itemIndex == widget.route.selectedIndex) {
      opacity = CurvedAnimation(
          parent: widget.route.animation!, curve: const Threshold(0.0));
    } else {
      final double start =
          (0.5 + (widget.itemIndex + 1) * unit).clamp(0.0, 1.0);
      final double end = (start + 1.5 * unit).clamp(0.0, 1.0);
      opacity = CurvedAnimation(
          parent: widget.route.animation!, curve: Interval(start, end));
    }
    Widget child = FadeTransition(
      opacity: opacity,
      child: Container(
        padding: widget.padding,
        margin: EdgeInsets.symmetric(vertical: widget.itemSpacing ?? 0),
        child: InkWell(
          autofocus: widget.itemIndex == widget.route.selectedIndex,
          onTap: _handleOnTap,
          onFocusChange: _handleFocusChange,
          child: widget.route.items[widget.itemIndex],
        ),
      ),
    );
    // child = Text('11');
    if (kIsWeb) {
      // On the web, enter doesn't select things, *except* in a <select>
      // element, which is what a dropdown emulates.
      child = Shortcuts(
        shortcuts: _webShortcuts,
        child: child,
      );
    }
    return child;
  }
}

///todo
class _DropdownMenu<T> extends StatefulWidget {
  const _DropdownMenu({
    Key? key,
    this.padding,
    required this.route,
    required this.buttonRect,
    required this.constraints,
    this.dropdownColor,
    this.dropdownBarrierColor,
    this.itemSpacing,
    this.menuMargin,
  }) : super(key: key);

  final _DropdownRoute<T> route;
  final EdgeInsets? padding;
  final Rect? buttonRect;
  final BoxConstraints? constraints;
  final Color? dropdownColor;
  final Color? dropdownBarrierColor;

  final double? itemSpacing;
  final EdgeInsets? menuMargin;

  @override
  _DropdownMenuState<T> createState() => _DropdownMenuState<T>();
}

class _DropdownMenuState<T> extends State<_DropdownMenu<T>> {
  late CurvedAnimation _fadeOpacity;
  CurvedAnimation? _resize;

  @override
  void initState() {
    super.initState();
    // We need to hold these animations as state because of their curve
    // direction. When the route's animation reverses, if we were to recreate
    // the CurvedAnimation objects in build, we'd lose
    // CurvedAnimation._curveDirection.
    _fadeOpacity = CurvedAnimation(
      parent: widget.route.animation!,
      curve: const Interval(0.0, 0.25),
      reverseCurve: const Interval(0.75, 1.0),
    );
    _resize = CurvedAnimation(
      parent: widget.route.animation!,
      curve: const Interval(0.25, 0.5),
      reverseCurve: const Threshold(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The menu is shown in three stages (unit timing in brackets):
    // [0s - 0.25s] - Fade in a rect-sized menu container with the selected item.
    // [0.25s - 0.5s] - Grow the otherwise empty menu container from the center
    //   until it's big enough for as many items as we're going to show.
    // [0.5s - 1.0s] Fade in the remaining visible items from top to bottom.
    //
    // When the menu is dismissed we just fade the entire thing out
    // in the first 0.25s.
    assert(debugCheckHasMaterialLocalizations(context));
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final _DropdownRoute<T> route = widget.route;
    var itemSpacing = widget.itemSpacing ?? 8.0;

    final List<Widget> children = <Widget>[
      for (int itemIndex = 0; itemIndex < route.items.length; ++itemIndex)
        _DropdownMenuItemButton<T>(
          route: widget.route,
          padding: widget.padding,
          buttonRect: widget.buttonRect,
          constraints: widget.constraints,
          itemIndex: itemIndex,
          itemSpacing: itemSpacing,
        ),
    ];
    final themeData = Theme.of(context);
    return FadeTransition(
      opacity: _fadeOpacity,
      child: CustomPaint(
        painter: _DropdownMenuPainter(
          //note:
          color: widget.dropdownColor ??
              themeData.bottomSheetTheme.backgroundColor ??
              themeData.canvasColor,
          dropdownBarrierColor: widget.dropdownBarrierColor ??
              themeData.bottomSheetTheme.modalBackgroundColor,
          elevation: route.elevation,
          selectedIndex: route.selectedIndex,
          resize: _resize,
          // This offset is passed as a callback, not a value, because it must
          // be retrieved at paint time (after layout), not at build time.
          getSelectedItemOffset: () => route.getItemOffset(route.selectedIndex),
          mediaQueryData: MediaQuery.of(context),
        ),
        child: Semantics(
          scopesRoute: true,
          namesRoute: true,
          explicitChildNodes: true,
          label: localizations.popupMenuLabel,
          child: Material(
            type: MaterialType.transparency,
            textStyle: route.style,
            child: ScrollConfiguration(
              behavior: const _DropdownScrollBehavior(),
              child: Container(
                margin: widget.menuMargin,
                child: Wrap(
                  children: children,
                  spacing: itemSpacing,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DropdownMenuRouteLayout<T> extends SingleChildLayoutDelegate {
  _DropdownMenuRouteLayout({
    this.offset,
    required this.buttonRect,
    required this.route,
    required this.textDirection,
  });

  final Rect? buttonRect;
  final _DropdownRoute<T>? route;
  final TextDirection textDirection;
  final double? offset;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The maximum height of a simple menu should be one or more rows less than
    // the view height. This ensures a tappable area outside of the simple menu
    // with which to dismiss the menu.
    //   -- https://material.io/design/components/menus.html#usage
    final double maxHeight = math.max(0.0, constraints.maxHeight);
    // The width of a menu should be at most the view width. This ensures that
    // the menu does not extend past the left and right edges of the screen.
    final double width = math.max(constraints.maxWidth, buttonRect!.width);
    return BoxConstraints(
      minWidth: width,
      maxWidth: width,
      minHeight: 0.0,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final _MenuLimits menuLimits =
        route!.getMenuLimits(buttonRect!, size.height, route!.selectedIndex);

    assert(() {
      final Rect container = Offset.zero & size;
      if (container.intersect(buttonRect!) == buttonRect) {
        // If the button was entirely on-screen, then verify
        // that the menu is also on-screen.
        // If the button was a bit off-screen, then, oh well.
        assert(menuLimits.top >= 0.0);
        assert(menuLimits.top + menuLimits.height <= size.height);
      }
      return true;
    }());
    assert(textDirection != null);
    late double left;
    switch (textDirection) {
      case TextDirection.rtl:
        left = buttonRect!.right.clamp(0.0, size.width) - childSize.width;
        break;
      case TextDirection.ltr:
        left = buttonRect!.left.clamp(0.0, size.width - childSize.width);
        break;
    }
    // note:
    return Offset(left, buttonRect!.height + menuLimits.top + (offset ?? 0));
  }

  @override
  bool shouldRelayout(_DropdownMenuRouteLayout<T> oldDelegate) {
    return buttonRect != oldDelegate.buttonRect ||
        textDirection != oldDelegate.textDirection;
  }
}

// We box the return value so that the return value can be null. Otherwise,
// canceling the route (which returns null) would get confused with actually
// returning a real null value.
@immutable
class _DropdownRouteResult<T> {
  const _DropdownRouteResult(this.result);

  final T result;

  @override
  bool operator ==(Object other) {
    return other is _DropdownRouteResult<T> && other.result == result;
  }

  @override
  int get hashCode => result.hashCode;
}

class _MenuLimits {
  const _MenuLimits(this.top, this.bottom, this.height, this.scrollOffset);

  final double top;
  final double bottom;
  final double height;
  final double scrollOffset;
}

class _DropdownRoute<T> extends PopupRoute<_DropdownRouteResult<T>> {
  _DropdownRoute({
    required this.items,
    this.padding,
    this.buttonRect,
    this.selectedIndex,
    this.elevation = 4,
    this.theme,
    required this.style,
    this.barrierLabel,
    this.itemHeight,
    this.dropdownColor,
    this.dropdownBarrierColor,
    this.offset,
    this.itemSpacing,
    this.menuMargin,
  })  : assert(style != null),
        itemHeights = List<double>.filled(items.length, itemHeight ?? 0);

  final List<_MenuItem<T>> items;
  final EdgeInsetsGeometry? padding;
  final Rect? buttonRect;
  final int? selectedIndex;
  final int elevation;
  final ThemeData? theme;
  final TextStyle style;
  final double? itemHeight;
  final Color? dropdownColor;
  final Color? dropdownBarrierColor;
  final double? offset;
  final double? itemSpacing;

  final List<double> itemHeights;
  ScrollController? scrollController;

  @override
  Duration get transitionDuration => _kDropdownMenuDuration;

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String? barrierLabel;

  final EdgeInsets? menuMargin;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return _DropdownRoutePage<T>(
        route: this,
        constraints: constraints,
        items: items,
        padding: padding,
        buttonRect: buttonRect,
        selectedIndex: selectedIndex,
        elevation: elevation,
        theme: theme,
        style: style,
        dropdownColor: dropdownColor,
        dropdownBarrierColor: dropdownBarrierColor,
        offset: offset,
        itemSpacing: itemSpacing,
        menuMargin: menuMargin,
      );
    });
  }

  void _dismiss() {
    navigator?.removeRoute(this);
  }

  double getItemOffset(int? index) {
    double offset = kMaterialListPadding.top;
    if (items.isNotEmpty && index! > 0) {
      assert(items.length == itemHeights.length);
      offset += itemHeights
          .sublist(0, index)
          .reduce((double total, double height) => total + height);
    }
    return offset;
  }

  // Returns the vertical extent of the menu and the initial scrollOffset
  // for the ListView that contains the menu items. The vertical center of the
  // selected item is aligned with the button's vertical center, as far as
  // that's possible given availableHeight.
  _MenuLimits getMenuLimits(
      Rect buttonRect, double availableHeight, int? index) {
    final double maxMenuHeight = availableHeight;
    final double buttonTop = buttonRect.top;
    final double buttonBottom = math.min(buttonRect.bottom, availableHeight);
    final double selectedItemOffset = getItemOffset(index);

    // If the button is placed on the bottom or top of the screen, its top or
    // bottom may be less than [_kMenuItemHeight] from the edge of the screen.
    // In this case, we want to change the menu limits to align with the top
    // or bottom edge of the button.
    final double topLimit = math.max(0, buttonTop);
    final double bottomLimit = math.max(availableHeight, buttonBottom);

    double menuTop = (buttonTop - selectedItemOffset) -
        (itemHeights[selectedIndex!] - buttonRect.height);
    // double preferredMenuHeight = kMaterialListPadding.vertical;
    double preferredMenuHeight = 0;
    if (items.isNotEmpty)
      preferredMenuHeight +=
          itemHeights.reduce((double total, double height) => total + height);

    // If there are too many elements in the menu, we need to shrink it down
    // so it is at most the maxMenuHeight.
    final double menuHeight = math.min(maxMenuHeight, preferredMenuHeight);
    double menuBottom = menuTop + menuHeight;

    // If the computed top or bottom of the menu are outside of the range
    // specified, we need to bring them into range. If the item height is larger
    // than the button height and the button is at the very bottom or top of the
    // screen, the menu will be aligned with the bottom or top of the button
    // respectively.
    if (menuTop < topLimit) menuTop = math.min(buttonTop, topLimit);

    if (menuBottom > bottomLimit) {
      menuBottom = math.max(buttonBottom, bottomLimit);
      menuTop = menuBottom - menuHeight;
    }

    // If all of the menu items will not fit within availableHeight then
    // compute the scroll offset that will line the selected menu item up
    // with the select item. This is only done when the menu is first
    // shown - subsequently we leave the scroll offset where the user left
    // it. This scroll offset is only accurate for fixed height menu items
    // (the default).
    final double scrollOffset = preferredMenuHeight <= maxMenuHeight
        ? 0
        : math.max(0.0, selectedItemOffset - (buttonTop - menuTop));

    return _MenuLimits(menuTop, menuBottom, menuHeight, scrollOffset);
  }
}

class _DropdownRoutePage<T> extends StatelessWidget {
  const _DropdownRoutePage({
    Key? key,
    this.offset,
    required this.route,
    this.constraints,
    this.items,
    this.padding,
    this.buttonRect,
    this.selectedIndex,
    this.elevation = 4,
    this.theme,
    this.style,
    this.dropdownColor,
    this.dropdownBarrierColor,
    this.itemSpacing,
    this.menuMargin,
  }) : super(key: key);

  final _DropdownRoute<T> route;
  final BoxConstraints? constraints;
  final List<_MenuItem<T>?>? items;
  final EdgeInsetsGeometry? padding;
  final Rect? buttonRect;
  final int? selectedIndex;
  final int elevation;
  final ThemeData? theme;
  final TextStyle? style;
  final Color? dropdownColor;
  final Color? dropdownBarrierColor;

  final double? offset;
  final double? itemSpacing;
  final EdgeInsets? menuMargin;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));

    // Computing the initialScrollOffset now, before the items have been laid
    // out. This only works if the item heights are effectively fixed, i.e. either
    // DropdownButton.itemHeight is specified or DropdownButton.itemHeight is null
    // and all of the items' intrinsic heights are less than kMinInteractiveDimension.
    // Otherwise the initialScrollOffset is just a rough approximation based on
    // treating the items as if their heights were all equal to kMinInteractveDimension.
    if (route.scrollController == null) {
      final _MenuLimits menuLimits = route.getMenuLimits(
          buttonRect!, constraints!.maxHeight, selectedIndex);
      route.scrollController =
          ScrollController(initialScrollOffset: menuLimits.scrollOffset);
    }

    final TextDirection textDirection = Directionality.of(context);
    //todo
    Widget menu = _DropdownMenu<T>(
      route: route,
      padding: padding!.resolve(textDirection),
      buttonRect: buttonRect,
      constraints: constraints,
      dropdownColor: dropdownColor,
      dropdownBarrierColor: dropdownBarrierColor,
      menuMargin: menuMargin,
    );
    if (theme != null) menu = Theme(data: theme!, child: menu);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          return CustomSingleChildLayout(
            delegate: _DropdownMenuRouteLayout<T>(
              //todo
              buttonRect: buttonRect,
              route: route,
              textDirection: textDirection,
              offset: offset,
            ),
            child: menu,
          );
        },
      ),
    );
  }
}

// This widget enables _DropdownRoute to look up the sizes of
// each menu item. These sizes are used to compute the offset of the selected
// item so that _DropdownRoutePage can align the vertical center of the
// selected item lines up with the vertical center of the dropdown button,
// as closely as possible.
class _MenuItem<T> extends SingleChildRenderObjectWidget {
  const _MenuItem({
    Key? key,
    required this.onLayout,
    required this.item,
  })   : assert(onLayout != null),
        super(key: key, child: item);

  final ValueChanged<Size> onLayout;
  final DropdownMenuItem<T> item;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderMenuItem(onLayout);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderMenuItem renderObject) {
    renderObject.onLayout = onLayout;
  }
}

class _RenderMenuItem extends RenderProxyBox {
  _RenderMenuItem(this.onLayout, [RenderBox? child])
      : assert(onLayout != null),
        super(child);

  ValueChanged<Size> onLayout;

  @override
  void performLayout() {
    super.performLayout();
    onLayout(size);
  }
}

// The container widget for a menu item created by a [DropdownButton]. It
// provides the default configuration for [DropdownMenuItem]s, as well as a
// [DropdownButton]'s hint and disabledHint widgets.
class _DropdownMenuItemContainer extends StatelessWidget {
  /// Creates an item for a dropdown menu.
  ///
  /// The [child] argument is required.
  const _DropdownMenuItemContainer({
    Key? key,
    required this.child,
  })   : assert(child != null),
        super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 0),
      // alignment: AlignmentDirectional.centerStart,
      child: child,
    );
  }
}

/// An item in a menu created by a [DropdownButton].
///
/// The type `T` is the type of the value the entry represents. All the entries
/// in a given menu must represent values with consistent types.
class DropdownMenuItem<T> extends _DropdownMenuItemContainer {
  /// Creates an item for a dropdown menu.
  ///
  /// The [child] argument is required.
  const DropdownMenuItem({
    Key? key,
    this.onTap,
    this.value,
    required Widget child,
  })   : assert(child != null),
        super(key: key, child: child);

  /// Called when the dropdown menu item is tapped.
  final VoidCallback? onTap;

  /// The value to return if the user selects this menu item.
  ///
  /// Eventually returned in a call to [DropdownButton.onChanged].
  final T? value;
}

class DropdownButton<T> extends StatefulWidget {
  DropdownButton({
    Key? key,
    required this.items,
    // this.selectedItemBuilder,
    this.child,
    this.onChanged,
    this.onTap,
    this.style,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24.0,
    // this.itemHeight = kMinInteractiveDimension,
    this.focusColor,
    this.focusNode,
    this.autofocus = false,
    this.dropdownColor,
    this.dropdownBarrierColor,
    this.offset,
    this.itemSpacing = 12,
    this.menuMargin = _kMenuMargin,
    this.dismissCallback,
  })  : assert(iconSize != null),
        assert(autofocus != null),
        assert(items != null && items.isNotEmpty),
        super(key: key);

  /// The list of items the user can select.
  ///
  /// If the [onChanged] callback is null or the list of items is null
  /// then the dropdown button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input. A disabled button
  /// will display the [disabledHint] widget if it is non-null. If
  /// [disabledHint] is also null but [hint] is non-null, [hint] will instead
  /// be displayed.
  final List<DropdownMenuItem<T>> items;

  /// The value of the currently selected [DropdownMenuItem].
  ///
  /// If [value] is null and [hint] is non-null, the [hint] widget is
  /// displayed as a placeholder for the dropdown button's value.
  final Widget? child;

  /// {@template flutter.material.dropdownButton.onChanged}
  /// Called when the user selects an item.
  ///
  /// If the [onChanged] callback is null or the list of [DropdownButton.items]
  /// is null then the dropdown button will be disabled, i.e. its arrow will be
  /// displayed in grey and it will not respond to input. A disabled button
  /// will display the [DropdownButton.disabledHint] widget if it is non-null.
  /// If [DropdownButton.disabledHint] is also null but [DropdownButton.hint] is
  /// non-null, [DropdownButton.hint] will instead be displayed.
  /// {@endtemplate}
  final ValueChanged<T>? onChanged;

  final VoidCallback? onTap;

  final VoidCallback? dismissCallback;

  // final DropdownButtonBuilder selectedItemBuilder;

  final TextStyle? style;

  /// The widget to use for the drop-down button's icon.
  ///
  /// Defaults to an [Icon] with the [Icons.arrow_drop_down] glyph.
  final Widget? icon;

  /// The color of any [Icon] descendant of [icon] if this button is disabled,
  /// i.e. if [onChanged] is null.
  ///
  /// Defaults to [MaterialColor.shade400] of [Colors.grey] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white10] when it is [Brightness.dark]
  final Color? iconDisabledColor;

  /// The color of any [Icon] descendant of [icon] if this button is enabled,
  /// i.e. if [onChanged] is defined.
  ///
  /// Defaults to [MaterialColor.shade700] of [Colors.grey] when the theme's
  /// [ThemeData.brightness] is [Brightness.light] and to
  /// [Colors.white70] when it is [Brightness.dark]
  final Color? iconEnabledColor;

  /// The size to use for the drop-down button's down arrow icon button.
  ///
  /// Defaults to 24.0.
  final double iconSize;

  /// If null, then the menu item heights will vary according to each menu item's
  /// intrinsic height.
  ///
  /// The default value is [kMinInteractiveDimension], which is also the minimum
  /// height for menu items.
  ///
  /// If this value is null and there isn't enough vertical room for the menu,
  /// then the menu's initial scroll offset may not align the selected item with
  /// the dropdown button. That's because, in this case, the initial scroll
  /// offset is computed as if all of the menu item heights were
  /// [kMinInteractiveDimension].
  // final double itemHeight;

  /// The color for the button's [Material] when it has the input focus.
  final Color? focusColor;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  /// The background color of the dropdown.
  ///
  /// If it is not provided, the theme's [ThemeData.canvasColor] will be used
  /// instead.
  final Color? dropdownColor;
  final Color? dropdownBarrierColor;

  final double? offset;

  final double itemSpacing;

  final EdgeInsets menuMargin;

  @override
  _DropdownButtonState<T> createState() => _DropdownButtonState<T>();
}

class _DropdownButtonState<T> extends State<DropdownButton<T>>
    with WidgetsBindingObserver {
  int? _selectedIndex;
  _DropdownRoute<T>? _dropdownRoute;
  Orientation? _lastOrientation;
  FocusNode? _internalNode;

  FocusNode? get focusNode => widget.focusNode ?? _internalNode;
  bool _hasPrimaryFocus = false;
  late Map<Type, Action<Intent>> _actionMap;
  FocusHighlightMode? _focusHighlightMode;

  // Only used if needed to create _internalNode.
  FocusNode _createFocusNode() {
    return FocusNode(debugLabel: '${widget.runtimeType}');
  }

  @override
  void initState() {
    super.initState();
    _updateSelectedIndex();
    if (widget.focusNode == null) {
      _internalNode ??= _createFocusNode();
    }
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (ActivateIntent intent) => _handleTap(),
      ),
    };
    focusNode!.addListener(_handleFocusChanged);
    final FocusManager focusManager = WidgetsBinding.instance!.focusManager;
    _focusHighlightMode = focusManager.highlightMode;
    focusManager.addHighlightModeListener(_handleFocusHighlightModeChange);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _removeDropdownRoute();
    WidgetsBinding.instance!.focusManager
        .removeHighlightModeListener(_handleFocusHighlightModeChange);
    focusNode!.removeListener(_handleFocusChanged);
    _internalNode?.dispose();
    super.dispose();
  }

  void _removeDropdownRoute() {
    widget.dismissCallback?.call();
    _dropdownRoute?._dismiss();
    _dropdownRoute = null;
    _lastOrientation = null;
  }

  void _handleFocusChanged() {
    if (_hasPrimaryFocus != focusNode!.hasPrimaryFocus) {
      setState(() {
        _hasPrimaryFocus = focusNode!.hasPrimaryFocus;
      });
    }
  }

  void _handleFocusHighlightModeChange(FocusHighlightMode mode) {
    if (!mounted) {
      return;
    }
    setState(() {
      _focusHighlightMode = mode;
    });
  }

  @override
  void didUpdateWidget(DropdownButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChanged);
      if (widget.focusNode == null) {
        _internalNode ??= _createFocusNode();
      }
      _hasPrimaryFocus = focusNode!.hasPrimaryFocus;
      focusNode!.addListener(_handleFocusChanged);
    }
    _updateSelectedIndex();
  }

  void _updateSelectedIndex() {
    if (!_enabled) {
      return;
    }
  }

  TextStyle? get _textStyle =>
      widget.style ?? Theme.of(context).textTheme.subtitle1;

  void _handleTap() {
    final RenderBox itemBox = context.findRenderObject() as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(Offset.zero) & itemBox.size;
    final TextDirection textDirection = Directionality.of(context);

    final List<_MenuItem<T>> menuItems = [
      for (int index = 0; index < widget.items.length; index += 1)
        _MenuItem<T>(
          item: widget.items[index],
          onLayout: (Size size) {
            // If [_dropdownRoute] is null and onLayout is called, this means
            // that performLayout was called on a _DropdownRoute that has not
            // left the widget tree but is already on its way out.
            //
            // Since onLayout is used primarily to collect the desired heights
            // of each menu item before laying them out, not having the _DropdownRoute
            // collect each item's height to lay out is fine since the route is
            // already on its way out.
            if (_dropdownRoute == null) return;
            _dropdownRoute!.itemHeights[index] = size.height;
          },
        )
    ];

    assert(_dropdownRoute == null);
    _dropdownRoute = _DropdownRoute<T>(
      items: menuItems,
      //todo
      buttonRect: itemRect,
      padding: EdgeInsets.zero,
      selectedIndex: _selectedIndex ?? 0,
      elevation: 0,
      theme: Theme.of(context),
      style: _textStyle!,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      // itemHeight: widget.itemHeight,
      dropdownColor: widget.dropdownColor,
      dropdownBarrierColor: widget.dropdownBarrierColor ??
          Colors.black.withOpacity(
              Theme.of(context).brightness == Brightness.dark ? 0.4 : 0.2),
      offset: widget.offset,
      itemSpacing: widget.itemSpacing,
      menuMargin: widget.menuMargin,
    );

    Navigator.push(context, _dropdownRoute!)
        .then<void>((_DropdownRouteResult<T>? newValue) {
      _removeDropdownRoute();
      if (!mounted || newValue == null) return;
      if (widget.onChanged != null) widget.onChanged!(newValue.result);
    });

    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  Color? get _iconColor {
    // These colors are not defined in the Material Design spec.
    if (_enabled) {
      if (widget.iconEnabledColor != null) return widget.iconEnabledColor;

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade700;
        case Brightness.dark:
          return Colors.white70;
      }
    } else {
      if (widget.iconDisabledColor != null) return widget.iconDisabledColor;

      switch (Theme.of(context).brightness) {
        case Brightness.light:
          return Colors.grey.shade400;
        case Brightness.dark:
          return Colors.white10;
      }
    }

    assert(false);
    return null;
  }

  bool get _enabled =>
      widget.items != null &&
      widget.items.isNotEmpty &&
      widget.onChanged != null;

  Orientation _getOrientation(BuildContext context) {
    Orientation? result = MediaQuery.of(context).orientation;
    // ignore: unnecessary_null_comparison
    if (result == null) {
      // If there's no MediaQuery, then use the window aspect to determine
      // orientation.
      final Size size = window.physicalSize;
      result = size.width > size.height
          ? Orientation.landscape
          : Orientation.portrait;
    }
    return result;
  }

  bool? get _showHighlight {
    switch (_focusHighlightMode) {
      case FocusHighlightMode.touch:
        return false;
      case FocusHighlightMode.traditional:
        return _hasPrimaryFocus;
      case null:
        return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    final Orientation newOrientation = _getOrientation(context);
    _lastOrientation ??= newOrientation;
    if (newOrientation != _lastOrientation) {
      _removeDropdownRoute();
      _lastOrientation = newOrientation;
    }

    Widget innerItemsWidget = widget.child ?? const SizedBox();

    const Icon defaultIcon = Icon(Icons.arrow_drop_down);

    Widget result = DefaultTextStyle(
      style: _textStyle!,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          innerItemsWidget,
          IconTheme(
            data: IconThemeData(
              color: _iconColor,
              size: widget.iconSize,
            ),
            child: widget.icon ?? defaultIcon,
          ),
        ],
      ),
    );

    return Semantics(
      button: true,
      child: Actions(
        actions: _actionMap,
        child: Focus(
          canRequestFocus: _enabled,
          focusNode: focusNode,
          autofocus: widget.autofocus,
          child: GestureDetector(
            onTap: _enabled ? _handleTap : null,
            behavior: HitTestBehavior.opaque,
            child: result,
          ),
        ),
      ),
    );
  }
}
