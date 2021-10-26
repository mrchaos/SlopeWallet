import 'package:flutter/material.dart';
import 'package:wallet/widgets/verification_box/verification_box_cursor.dart';

///
///
///
enum VerificationBoxItemType {
  ///
  ///
  ///
  underline,

  ///
  ///
  ///
  box,
}

///
///
///
class VerificationBoxItem extends StatelessWidget {
  VerificationBoxItem({
    this.data = '',
    required this.textStyle,
    required this.cursorColor,
    this.type = VerificationBoxItemType.box,
    this.decoration,
    this.borderRadius = 5.0,
    this.borderWidth = 2.0,
    this.borderColor,
    this.showCursor = false,
    this.cursorWidth = 2,
    this.cursorIndent = 5,
    this.cursorEndIndent = 5,
    this.obscureTextSize = 8,
  });

  final String data;
  final VerificationBoxItemType type;
  final double borderWidth;
  final Color? borderColor;
  final double borderRadius;
  final double obscureTextSize;
  final TextStyle textStyle;
  final Decoration? decoration;

  ///
  ///
  ///
  final bool showCursor;

  ///
  ///
  ///
  final Color cursorColor;

  ///
  ///
  ///
  final double cursorWidth;

  ///
  ///
  ///
  final double cursorIndent;

  ///
  ///
  ///
  final double cursorEndIndent;

  @override
  Widget build(BuildContext context) {
    var borderColor = this.borderColor ?? Theme.of(context).dividerColor;
    var text = _buildText();
    var widget;
    if (type == VerificationBoxItemType.box) {
      widget = _buildBoxDecoration(text, borderColor);
    } else {
      widget = _buildUnderlineDecoration(text, borderColor);
    }

    return Stack(
      children: <Widget>[
        widget,
        showCursor
            ? Positioned.fill(
                child: VerificationBoxCursor(
                color: cursorColor,
                width: cursorWidth,
                indent: cursorIndent,
                endIndent: cursorEndIndent,
              ))
            : Container()
      ],
    );
  }

  ///
  ///
  ///
  _buildBoxDecoration(Widget child, Color borderColor) {
    return Container(
      alignment: Alignment.center,
      decoration: decoration ??
          BoxDecoration(
              borderRadius: BorderRadius.circular(this.borderRadius),
              border: Border.all(color: borderColor, width: this.borderWidth)),
      child: child,
    );
  }

  ///
  ///
  ///
  _buildUnderlineDecoration(Widget child, Color borderColor) {
    return Container(
      alignment: Alignment.center,
      decoration: UnderlineTabIndicator(
          borderSide: BorderSide(width: this.borderWidth, color: borderColor)),
      child: child,
    );
  }

  ///
  ///
  ///
  _buildText() {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 30),
      firstChild: Text(
        '$data',
        style: textStyle,
      ),
      secondChild: CircleAvatar(
        backgroundColor: textStyle.color,
        radius: obscureTextSize / 2,
      ),
      crossFadeState:
          '•' == data ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}
