import 'package:flutter/material.dart';
import 'package:wallet/common/config/net_config/net_config.dart';
import 'package:wallet/theme/app_theme.dart';

class MnemonicWordItem extends StatefulWidget {
  final String number;
  final String word;
  final bool isWaitingInput;
  final VoidCallback onTap;

  const MnemonicWordItem(
      {Key? key,
      required this.number,
      required this.word,
      this.isWaitingInput = false,
      required this.onTap})
      : super(key: key);

  @override
  _MnemonicWordItemState createState() => _MnemonicWordItemState();
}

class _MnemonicWordItemState extends State<MnemonicWordItem> {
  @override
  Widget build(BuildContext context) {
    late Color bgColor;
    late Color bdColor;
    if (widget.isWaitingInput) {
      bgColor = AppTheme.of(context).currentColors.backgroundColor;
      bdColor = AppTheme.of(context).currentColors.purpleAccent;
    } else {
      bgColor = AppTheme.of(context).themeMode == ThemeMode.light
          ? AppTheme.of(context).currentColors.lightGray
          : AppTheme.of(context).currentColors.dividerColor;
      bdColor = AppTheme.of(context).themeMode == ThemeMode.light
          ? AppTheme.of(context).currentColors.lightGray
          : AppTheme.of(context).currentColors.dividerColor;
    }
    double textSize = 14.0;
    if (widget.word.length > 8) {
      textSize = 10.0;
    } else if (widget.word.length > 6 && widget.word.length <= 8) {
      textSize = 12.0;
    }

    return InkWell(
      onTap: () => widget.onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: bdColor, width: 1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.number,
              style: TextStyle(
                color: AppTheme.of(context).currentColors.textColor3,
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Text(
                widget.word,
                maxLines: 1,
                style: TextStyle(
                  color: AppTheme.of(context).currentColors.textColor1,
                  fontSize: textSize,
                  fontWeight: FontWeight.w500,
                ),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
