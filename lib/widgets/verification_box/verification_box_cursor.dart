
import 'package:flutter/material.dart';

///
/// des: 
///
class VerificationBoxCursor extends StatefulWidget {

  VerificationBoxCursor({required this.color,required this.width, required this.indent,required this.endIndent});

  ///
  /// 
  ///
  final Color color;

  ///
  /// 
  ///
  final double width;

  ///
  /// 
  ///
  final double indent;

  ///
  /// 
  ///
  final double endIndent;

  @override
  State<StatefulWidget> createState() => _VerificationBoxCursorState();
}

class _VerificationBoxCursorState extends State<VerificationBoxCursor>
    with SingleTickerProviderStateMixin {
 late AnimationController _controller;

  @override
  void initState() {
    _controller =
    AnimationController(duration: Duration(milliseconds: 500), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: VerticalDivider(
        thickness: widget.width,
        color: widget.color,
        indent: widget.indent,
        endIndent: widget.endIndent,
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
