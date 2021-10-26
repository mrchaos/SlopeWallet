import 'package:flutter/material.dart';
import 'package:wallet/theme/app_theme.dart';

class MenuTile extends StatefulWidget {
  static const _defaultHeight = 48.0;
  final double? height;
  final Widget? leading;
  final double? leadingSize;
  final Widget? title;
  final Widget? trailing;

  final EdgeInsets? margin;
  final Border? border;
  final Color? color;
  final VoidCallback? onPressed;
  final BorderRadius? borderRadius;
  final double? paddingSize;

  MenuTile({
    Key? key,
    this.height = _defaultHeight,
    this.leading,
    this.leadingSize = 24,
    this.title,
    this.trailing,
    this.border,
    this.color,
    this.onPressed,
    this.margin,
    this.borderRadius,
    this.paddingSize = 20,
  }) : super(key: key);

  @override
  _MenuTileState createState() => _MenuTileState();
}

class _MenuTileState extends State<MenuTile> {
  @override
  Widget build(BuildContext context) {
    // const padding =  EdgeInsets.only(left: widget.paddingSize ?? 20, right: widget.paddingSize ?? 20);
    const iconMargin = const EdgeInsets.only(right: 8);
    return InkWell(
      borderRadius: widget.borderRadius,
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.of(context).currentColors.backgroundColor),
        margin: widget.margin,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: widget.paddingSize ?? 20,
                  right: widget.paddingSize ?? 20),
              height: widget.height ?? MenuTile._defaultHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // left
                  if (widget.leading != null)
                    Container(
                      margin: iconMargin,
                      child: widget.leading,
                      width: widget.leadingSize ?? 0,
                      height: widget.leadingSize ?? 0,
                    ),
                  // center
                  widget.title ?? const SizedBox(),
                  // right
                  if (null != widget.trailing)
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(left: 8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: widget.trailing,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
