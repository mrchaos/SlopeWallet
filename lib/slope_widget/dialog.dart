import 'package:flutter/material.dart';
import 'package:wallet/slope_widget/button.dart';
import 'package:wallet/theme/app_theme.dart';

Future<T?> showSlopeConfirmDialog<T>({
  required BuildContext context,
  String? title,
  String? content,
  String? confirmLabel = 'Done',
  bool barrierDismissible = false,
  Color? backgroundColor,
  Color? barrierColor,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    builder: (c) => SlopeAlertDialog(
      title: title,
      content: content,
      confirmLabel: confirmLabel,
      backgroundColor: backgroundColor,
    ),
  );
}

class SlopeAlertDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? confirmLabel;
  final VoidCallback? onConfirm;
  final Color? backgroundColor;

  const SlopeAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.confirmLabel,
    this.onConfirm,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (null != title)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                height: 22 / 18,
                fontWeight: FontWeight.w500,
                color: context.appColors.textColor1,
              ),
            ),
          if (null != content)
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                child: SingleChildScrollView(
                  child: Text(
                    content!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 18 / 14,
                      fontWeight: FontWeight.w400,
                      color: context.appColors.textColor2,
                    ),
                  ),
                ),
              ),
            ),
          Container(
            constraints: BoxConstraints.tightFor(width: 153),
            margin: const EdgeInsets.only(top: 20),
            child: SlopeConfirmButton(
              height: 40,
              onPressed: onConfirm ?? () => Navigator.pop(context),
              text: confirmLabel ?? '',
            ),
          )
        ],
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 48),
    );
  }
}
