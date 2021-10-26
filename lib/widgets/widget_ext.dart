import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

extension WidgetChantExt_Widget on Widget {
  List<Widget> addNeighbor(Widget widget) {
    return <Widget>[this, widget];
  }

  List<Widget> addBeforeNeighbor(Widget widget) {
    return <Widget>[widget, this];
  }

  Stack intoStack({Key? key,
    AlignmentGeometry alignment = AlignmentDirectional.topStart,
    TextDirection? textDirection,
    StackFit fit = StackFit.loose,
    Clip clipBehavior = Clip.hardEdge
    // Overflow overflow = Overflow.clip,
  }) {
    return Stack(
      key: key,
      alignment: alignment,
      textDirection: textDirection,
      fit: fit,
      // overflow: overflow,
      clipBehavior: clipBehavior,
      children: this.asList(),
    );
  }

  List<Widget> asList() {
    return [this];
  }

  Align intoAlign({
    Key? key,
    Alignment alignment = Alignment.center,
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      key: key,
      alignment: alignment,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  ClipRRect intoClipRRect({
    Key? key,
    BorderRadius borderRadius = BorderRadius.zero,
    CustomClipper<RRect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    return ClipRRect(
      key: key,
      borderRadius: borderRadius,
      clipper: clipper,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  ClipRect intoClipRect({
    Key? key,
    CustomClipper<Rect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    return ClipRect(
      key: key,
      clipper: clipper,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  ClipOval intoClipOval({
    Key? key,
    BorderRadius borderRadius = BorderRadius.zero,
    CustomClipper<Rect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    return ClipOval(
      key: key,
      clipper: clipper,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  ClipPath intoClipPath({
    Key? key,
    BorderRadius borderRadius = BorderRadius.zero,
    CustomClipper<Path>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    return ClipPath(
      key: key,
      clipper: clipper,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  Offstage intoOffstage({
    Key? key,
    bool offstage = true,
  }) {
    return Offstage(
      key: key,
      offstage: offstage,
      child: this,
    );
  }

  Padding intoPadding({
    Key? key,
    required EdgeInsetsGeometry padding,
  }) {
    return Padding(
      key: key,
      padding: padding,
      child: this,
    );
  }

  Positioned intoPositioned({
    Key? key,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) {
    return Positioned(
      key: key,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      width: width,
      height: height,
      child: this,
    );
  }

  Center intoCenter({
    Key? key,
    double? widthFactor,
    double? heightFactor,
  }) {
    return Center(
      key: key,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  Expanded intoExpanded({
    Key? key,
    int flex = 1,
  }) {
    return Expanded(
      key: key,
      flex: flex,
      child: this,
    );
  }

  Flexible intoFlexible({
    Key? key,
    int flex = 1,
    FlexFit fit = FlexFit.loose,
  }) {
    return Flexible(
      key: key,
      flex: flex,
      fit: fit,
      child: this,
    );
  }

  SizedBox intoSizedBox({
    Key? key,
    double? width,
    double? height,
  }) {
    return SizedBox(
      key: key,
      width: width,
      height: height,
      child: this,
    );
  }

  IntrinsicWidth intoIntrinsicWidth({
    Key? key,
    double? stepWidth,
    double? stepHeight,
  }) {
    return IntrinsicWidth(
      key: key,
      stepWidth: stepWidth,
      stepHeight: stepHeight,
      child: this,
    );
  }

  IntrinsicHeight intoIntrinsicHeight({
    Key? key,
  }) {
    return IntrinsicHeight(
      key: key,
      child: this,
    );
  }

  CupertinoScrollbar intoCupertinoScrollbar({
    Key? key,
    ScrollController? controller,
    bool isAlwaysShown = false,
    double thickness = CupertinoScrollbar.defaultThickness,
    double thicknessWhileDragging =
        CupertinoScrollbar.defaultThicknessWhileDragging,
    Radius radius = CupertinoScrollbar.defaultRadius,
    Radius radiusWhileDragging = CupertinoScrollbar.defaultRadiusWhileDragging,
  }) {
    return CupertinoScrollbar(
      key: key,
      child: this,
      controller: controller,
      isAlwaysShown: isAlwaysShown,
      thickness: thickness,
      thicknessWhileDragging: thicknessWhileDragging,
      radius: radius,
      radiusWhileDragging: radiusWhileDragging,
    );
  }

  Scrollbar intoScrollbar({
    Key? key,
    ScrollController? controller,
    bool isAlwaysShown = false,
    double? thickness,
    double? thicknessWhileDragging,
    Radius? radius,
    Radius? radiusWhileDragging,
  }) {
    return Scrollbar(
      key: key,
      child: this,
      controller: controller,
      isAlwaysShown: isAlwaysShown,
      thickness: thickness,
      radius: radius,
    );
  }

  LimitedBox intoLimitedBox({
    Key? key,
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
  }) {
    return LimitedBox(
      key: key,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      child: this,
    );
  }

  OverflowBox intoOverflowBox({
    Key? key,
    Alignment alignment = Alignment.center,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return OverflowBox(
      key: key,
      alignment: alignment,
      minWidth: minWidth,
      minHeight: minHeight,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      child: this,
    );
  }

  SizedOverflowBox intoSizedOverflowBox({
    Key? key,
    required Size size,
    Alignment alignment = Alignment.center,
  }) {
    return SizedOverflowBox(
      key: key,
      size: size,
      alignment: alignment,
      child: this,
    );
  }

  FittedBox intoFittedBox({
    Key? key,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return FittedBox(
      key: key,
      fit: fit,
      alignment: alignment,
      child: this,
    );
  }

  DecoratedBox intoDecoratedBox({
    Key? key,
    required Decoration decoration,
    DecorationPosition position = DecorationPosition.background,
  }) {
    return DecoratedBox(
      key: key,
      decoration: decoration,
      position: position,
      child: this,
    );
  }

  RotatedBox intoRotatedBox({
    Key? key,
    required int quarterTurns,
  }) {
    return RotatedBox(
      key: key,
      quarterTurns: quarterTurns,
      child: this,
    );
  }

  ConstrainedBox intoConstrainedBox({
    Key? key,
    required BoxConstraints constraints,
  }) {
    return ConstrainedBox(
      key: key,
      constraints: constraints,
      child: this,
    );
  }

  UnconstrainedBox intoUnconstrainedBox({
    Key? key,
    TextDirection? textDirection,
    Alignment alignment = Alignment.center,
    Axis? constrainedAxis,
  }) {
    return UnconstrainedBox(
      key: key,
      textDirection: textDirection,
      alignment: alignment,
      constrainedAxis: constrainedAxis,
      child: this,
    );
  }

  AnimatedAlign intoAnimatedAlign({
    Key? key,
    Alignment alignment = Alignment.center,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) {
    return AnimatedAlign(
      key: key,
      alignment: alignment,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: this,
    );
  }

  AnimatedPadding intoAnimatedPadding({
    Key? key,
    required EdgeInsetsGeometry padding,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) {
    return AnimatedPadding(
      key: key,
      padding: padding,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: this,
    );
  }

  AnimatedContainer intoAnimatedContainer({
    Key? key,
    Alignment? alignment,
    EdgeInsetsGeometry? padding,
    Color? color,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) {
    return AnimatedContainer(
      key: key,
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
      child: this,
    );
  }

  SingleChildScrollView intoSingleChildScrollView({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    EdgeInsetsGeometry? padding,
    bool? primary,
    ScrollPhysics? physics,
    ScrollController? controller,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
  }) {
    return SingleChildScrollView(
      key: key,
      scrollDirection: scrollDirection,
      reverse: reverse,
      padding: padding,
      primary: primary,
      physics: physics,
      controller: controller,
      dragStartBehavior: dragStartBehavior,
      child: this,
    );
  }

  @Deprecated(
      'Use intoTextButton instead. This feature was deprecated after v1.25.0-8.1.pre.')
  FlatButton intoFlatButton({
    Key? key,
    required VoidCallback onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHighlightChanged,
    ButtonTextTheme? textTheme,
    Color? textColor,
    Color? disabledTextColor,
    Color? color,
    Color? disabledColor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    Brightness? colorBrightness,
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
    ShapeBorder? shape,
    Clip clipBehavior = Clip.none,
    FocusNode? focusNode,
    bool autofocus = false,
    MaterialTapTargetSize? materialTapTargetSize,
  }) {
    return FlatButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      textTheme: textTheme,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      color: color,
      disabledColor: disabledColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      colorBrightness: colorBrightness,
      padding: padding,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      child: this,
    );
  }

  TextButton intoTextButton({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
  }) {
    return TextButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      child: this,
    );
  }

  GestureDetector onTap(GestureTapCallback onTap, {Key? key}) {
    return intoGestureDetector(
        onTap: onTap, key: key, behavior: HitTestBehavior.opaque);
  }

  GestureDetector onDoubleTap(GestureTapCallback onDoubleTap, {Key? key}) {
    return intoGestureDetector(onDoubleTap: onDoubleTap, key: key);
  }

  GestureDetector onLongPress(GestureLongPressCallback onLongPress,
      {Key? key}) {
    return intoGestureDetector(onLongPress: onLongPress, key: key);
  }

  GestureDetector intoGestureDetector({
    Key? key,
    GestureTapDownCallback? onTapDown,
    GestureTapUpCallback? onTapUp,
    GestureTapCallback? onTap,
    GestureTapCancelCallback? onTapCancel,
    GestureTapDownCallback? onSecondaryTapDown,
    GestureTapUpCallback? onSecondaryTapUp,
    GestureTapCancelCallback? onSecondaryTapCancel,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureLongPressStartCallback? onLongPressStart,
    GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate,
    GestureLongPressUpCallback? onLongPressUp,
    GestureLongPressEndCallback? onLongPressEnd,
    GestureDragDownCallback? onVerticalDragDown,
    GestureDragStartCallback? onVerticalDragStart,
    GestureDragUpdateCallback? onVerticalDragUpdate,
    GestureDragEndCallback? onVerticalDragEnd,
    GestureDragCancelCallback? onVerticalDragCancel,
    GestureDragDownCallback? onHorizontalDragDown,
    GestureDragStartCallback? onHorizontalDragStart,
    GestureDragUpdateCallback? onHorizontalDragUpdate,
    GestureDragEndCallback? onHorizontalDragEnd,
    GestureDragCancelCallback? onHorizontalDragCancel,
    GestureForcePressStartCallback? onForcePressStart,
    GestureForcePressPeakCallback? onForcePressPeak,
    GestureForcePressUpdateCallback? onForcePressUpdate,
    GestureForcePressEndCallback? onForcePressEnd,
    GestureDragDownCallback? onPanDown,
    GestureDragStartCallback? onPanStart,
    GestureDragUpdateCallback? onPanUpdate,
    GestureDragEndCallback? onPanEnd,
    GestureDragCancelCallback? onPanCancel,
    GestureScaleStartCallback? onScaleStart,
    GestureScaleUpdateCallback? onScaleUpdate,
    GestureScaleEndCallback? onScaleEnd,
    HitTestBehavior? behavior,
    bool excludeFromSemantics = false,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
  }) {
    return GestureDetector(
      key: key,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTap: onTap,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onLongPressStart: onLongPressStart,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressUp: onLongPressUp,
      onLongPressEnd: onLongPressEnd,
      onVerticalDragDown: onVerticalDragDown,
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      onVerticalDragCancel: onVerticalDragCancel,
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragCancel: onHorizontalDragCancel,
      onForcePressStart: onForcePressStart,
      onForcePressPeak: onForcePressPeak,
      onForcePressUpdate: onForcePressUpdate,
      onForcePressEnd: onForcePressEnd,
      onPanDown: onPanDown,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      onPanCancel: onPanCancel,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      behavior: behavior,
      excludeFromSemantics: excludeFromSemantics,
      dragStartBehavior: dragStartBehavior,
      child: this,
    );
  }

  Divider intoDivider({
    Key? key,
    double? height,
    double? thickness,
    double? indent,
    double? endIndent,
    Color? color,
  }) {
    return Divider(
      key: key,
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color,
    );
  }

  Container intoContainer({
    Key? key,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? padding,
    Color? color,
    Decoration? decoration,
    Decoration? foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? margin,
    Matrix4? transform,
  }) {
    return Container(
      key: key,
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      child: this,
    );
  }

  Hero intoHero({
    Key? key,
    required Object tag,
    CreateRectTween? createRectTween,
    HeroFlightShuttleBuilder? flightShuttleBuilder,
    HeroPlaceholderBuilder? placeholderBuilder,
    bool transitionOnUserGestures = false,
  }) {
    return Hero(
        key: key,
        tag: tag,
        createRectTween: createRectTween,
        flightShuttleBuilder: flightShuttleBuilder,
        placeholderBuilder: placeholderBuilder,
        transitionOnUserGestures: transitionOnUserGestures,
        child: this);
  }

  Card intoCard({
    Key? key,
    Color? color,
    Color? shadowColor,
    double? elevation,
    ShapeBorder? shape,
    bool borderOnForeground = true,
    EdgeInsetsGeometry? margin,
    Clip? clipBehavior,
    bool semanticContainer = true,
  }) {
    return Card(
      key: key,
      color: color,
      elevation: elevation,
      shape: shape,
      borderOnForeground: borderOnForeground,
      margin: margin,
      clipBehavior: clipBehavior,
      semanticContainer: semanticContainer,
      shadowColor: shadowColor,
      child: this,
    );
  }

  DefaultTextStyle intoDefaultTextStyle({
    Key? key,
    required TextStyle style,
    TextAlign? textAlign,
    bool softWrap = true,
    TextOverflow overflow = TextOverflow.clip,
    int? maxLines,
    TextWidthBasis textWidthBasis = TextWidthBasis.parent,
  }) {
    return DefaultTextStyle(
      style: style,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textWidthBasis: textWidthBasis,
      child: this,
    );
  }

  InkWell intoInkWell({
    Key? key,
    GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureTapDownCallback? onTapDown,
    GestureTapCancelCallback? onTapCancel,
    ValueChanged<bool>? onHighlightChanged,
    ValueChanged<bool>? onHover,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    InteractiveInkFeatureFactory? splashFactory,
    double? radius,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    bool enableFeedback = true,
    bool excludeFromSemantics = false,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    ValueChanged<bool>? onFocusChange,
    bool autofocus = false,
  }) {
    return InkWell(
      key: key,
      child: this,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTapDown: onTapDown,
      onTapCancel: onTapCancel,
      onHighlightChanged: onHighlightChanged,
      onHover: onHover,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      splashFactory: splashFactory,
      radius: radius,
      borderRadius: borderRadius,
      customBorder: customBorder,
      enableFeedback: enableFeedback,
      excludeFromSemantics: excludeFromSemantics,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
    );
  }

  Tooltip intoTooltip({
    Key? key,
    required String message,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? verticalOffset,
    bool? preferBelow,
    bool? excludeFromSemantics,
    Decoration? decoration,
    TextStyle? textStyle,
    Duration? waitDuration,
    Duration? showDuration,
  }) {
    return Tooltip(
      key: key,
      message: message,
      height: height,
      padding: padding,
      margin: margin,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
      excludeFromSemantics: excludeFromSemantics,
      decoration: decoration,
      textStyle: textStyle,
      waitDuration: waitDuration,
      showDuration: showDuration,
      child: this,
    );
  }

  ///WidgetiOS
  ScrollConfiguration intoScrollConfiguration({
    Key? key,
    ScrollBehavior behavior = const CupertinoScrollBehavior(),
  }) {
    return ScrollConfiguration(
      key: key,
      behavior: behavior,
      child: this,
    );
  }
}
