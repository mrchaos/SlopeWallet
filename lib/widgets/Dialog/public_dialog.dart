import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wallet/slope_widget/button.dart';
import 'package:wallet/theme/app_theme.dart';

///
Future<T?> showAlertHorizontalButtonDialog<T>({
  required BuildContext context,
  Key? key,
  String? title,
  String? content,
  VoidCallback? cancelPressed,
  VoidCallback? confirmPressed,
  String? cancelButtonLabel,
  String? confirmButtonLabel,
  bool showConfirmButton = true,
  bool showCancelButton = true,
  bool barrierDismissible = true,
  Color? barrierColor,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  TextStyle? cancelButtonStyle,
  TextStyle? confirmButtonStyle,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    useSafeArea: useSafeArea,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (c) => StatefulBuilder(
        key: key,
        builder: (context, setState) {
          return WillPopScope(
            onWillPop: () => Future.value(barrierDismissible),
            child: KAlertDialog(
              title: title,
              content: content,
              cancelPressed: cancelPressed,
              confirmPressed: confirmPressed,
              cancelButtonLabel: cancelButtonLabel,
              confirmButtonLabel: confirmButtonLabel,
              showCancelButton: showCancelButton,
              showConfirmButton: showConfirmButton,
              cancelButtonStyle: cancelButtonStyle,
              confirmButtonStyle: confirmButtonStyle,
            ),
          );
        }),
  );
}

class KAlertDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? cancelButtonLabel;
  final String? confirmButtonLabel;
  final VoidCallback? cancelPressed;
  final VoidCallback? confirmPressed;
  final bool showConfirmButton;
  final bool showCancelButton;
  final TextStyle? cancelButtonStyle;
  final TextStyle? confirmButtonStyle;

  const KAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.cancelPressed,
    this.confirmPressed,
    this.cancelButtonLabel,
    this.confirmButtonLabel,
    this.showCancelButton = true,
    this.showConfirmButton = true,
    this.cancelButtonStyle,
    this.confirmButtonStyle,
  }) : super(key: key);

  Widget get androidAlertDialog => Builder(builder: (context) {
        return AlertDialog(
          title: title == null ? null : Text(title ?? ''),
          content: content == null ? null : Text(content ?? ''),
          actions: [
            if (showCancelButton != false)
              TextButton(
                  onPressed: cancelPressed ?? () => Navigator.pop(context),
                  child: Text(
                    cancelButtonLabel ?? 'Cancel',
                    style: cancelButtonStyle,
                  )),
            if (showConfirmButton != false)
              TextButton(
                  onPressed: confirmPressed ?? () => Navigator.pop(context),
                  child: Text(
                    confirmButtonLabel ?? MaterialLocalizations.of(context).okButtonLabel,
                    style: confirmButtonStyle,
                  )),
          ],
        );
      });

  Widget get iosAlertDialog => Builder(builder: (context) {
        return CupertinoAlertDialog(
          title: title == null ? null : Text(title ?? ''),
          content: content == null ? null : Text(content ?? ''),
          actions: [
            if (showCancelButton != false)
              CupertinoDialogAction(
                  onPressed: cancelPressed ?? () => Navigator.pop(context),
                  child: Text(
                    cancelButtonLabel ?? 'Cancel',
                    style: cancelButtonStyle,
                  )),
            if (showConfirmButton != false)
              CupertinoDialogAction(
                  onPressed: confirmPressed ?? () => Navigator.pop(context),
                  child: Text(
                    confirmButtonLabel ?? 'Ok',
                    style: confirmButtonStyle,
                  )),
          ],
        );
      });

  @override
  Widget build(BuildContext context) {
    final ios = Theme.of(context).platform == TargetPlatform.iOS;
    return ios ? iosAlertDialog : androidAlertDialog;
  }
}

///
showAlertVerticalButtonDialog({
  required BuildContext context,
  String? title,
  String? content,
  VoidCallback? subButtonPressed,
  VoidCallback? mainButtonPressed,
  String? subButtonLabel,
  String? mainButtonLabel,
  bool showMainButton = true,
  bool showSubButton = true,
  bool barrierDismissible = true,
  Color? barrierColor,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor ?? Color(0xFF000000).withOpacity(0.4),
    useSafeArea: useSafeArea,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (c) => WillPopScope(
      onWillPop: () => Future.value(barrierDismissible),
      child: _AlertVerticalButtonDialog(
        title: title,
        content: content,
        subButtonPressed: subButtonPressed,
        mainButtonPressed: mainButtonPressed,
        subButtonLabel: subButtonLabel,
        mainButtonLabel: mainButtonLabel,
        showSubButton: showSubButton,
        showMainButton: showMainButton,
      ),
    ),
  );
}

class _AlertVerticalButtonDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? subButtonLabel;
  final String? mainButtonLabel;
  final VoidCallback? subButtonPressed;
  final VoidCallback? mainButtonPressed;
  final bool showMainButton;
  final bool showSubButton;

  const _AlertVerticalButtonDialog({
    Key? key,
    this.title,
    this.content,
    this.subButtonPressed,
    this.mainButtonPressed,
    this.subButtonLabel,
    this.mainButtonLabel,
    this.showSubButton = true,
    this.showMainButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appColors = AppTheme.of(context).currentColors;

    return AlertDialog(
      backgroundColor: AppTheme.of(context).currentColors.backgroundColor,
      titlePadding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      contentPadding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 20),
      insetPadding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          height: 22 / 18,
          color: appColors.textColor1,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        content ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          height: 18 / 14,
          color: appColors.textColor6,
        ),
      ),
      actionsPadding: EdgeInsets.only(left: 20, right: 20),
      buttonPadding: EdgeInsets.zero,
      actions: [
        Column(
          children: [
            if (showMainButton)
              Container(
                height: 40,
                constraints: BoxConstraints(minWidth: double.maxFinite),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  child: Text(
                    mainButtonLabel ?? 'Ok',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppTheme.of(context).currentColors.purpleAccent),
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                  ),
                  onPressed: mainButtonPressed ?? () => Navigator.pop(context),
                ),
              ),
            (showSubButton)
                ? Container(
                    // margin: const EdgeInsets.only(top: 16),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: subButtonPressed ?? () => Navigator.pop(context),
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                        child: Text(
                          subButtonLabel ?? 'Cancel',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: appColors.textColor3,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 20,
                  ),
          ],
        ),
      ],
    );
  }
}

/// （）
showVersionCheckDialog({
  required BuildContext context,
  String title = 'New Version 1.1.0',
  String? content =
      '1. Optimized some functions in KYC proccess.\n2. Fixed some user interaction experience issues',
  VoidCallback? subButtonPressed,
  VoidCallback? mainButtonPressed,
  String subButtonLabel = 'Later',
  String mainButtonLabel = 'Update',
  bool showMainButton = true,
  bool showSubButton = true,
  bool barrierDismissible = false,
  Color barrierColor = const Color.fromRGBO(0, 0, 0, 0.4),
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor,
    useSafeArea: useSafeArea,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    builder: (context) => WillPopScope(
      onWillPop: () => Future.value(barrierDismissible),
      child: _VersionCheckAlertDialog(
        title: title,
        content: content,
        subButtonPressed: subButtonPressed,
        mainButtonPressed: mainButtonPressed ??
            () {
              //dismiss dialog
              Navigator.pop(context);
            },
        subButtonLabel: subButtonLabel,
        mainButtonLabel: mainButtonLabel,
        showSubButton: showSubButton,
        showMainButton: showMainButton,
      ),
    ),
  );
}

class _VersionCheckAlertDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? subButtonLabel;
  final String? mainButtonLabel;
  final VoidCallback? subButtonPressed;
  final VoidCallback? mainButtonPressed;
  final bool? showMainButton;
  final bool? showSubButton;

  const _VersionCheckAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.subButtonPressed,
    this.mainButtonPressed,
    this.subButtonLabel,
    this.mainButtonLabel,
    required this.showSubButton,
    required this.showMainButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appColors = AppTheme.of(context).currentColors;
    double horizontal = 48;
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 24),
      titlePadding: EdgeInsets.zero,
      elevation: 0,
      title: Container(
        decoration: BoxDecoration(
          color: appColors.backgroundColor, //Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 22, bottom: 10, left: 16, right: 16),
              child: Text(
                title ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: appColors.textColor1, //appColors.textColor1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (content?.isNotEmpty ?? true)
              Container(
                padding: EdgeInsets.only(left: 44, right: 44),
                child: SingleChildScrollView(
                  child: Text(
                    content ?? '',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      height: 20 / 16,
                      color: appColors.textColor6, //appColors.textColor1,
                    ),
                  ),
                ),
              ),
            if (content?.isNotEmpty ?? true) const SizedBox(height: 20),
            (!showSubButton! && showMainButton!)
                ? Padding(
                    padding: EdgeInsets.only(left: 64, right: 64),
                    child: SlopeConfirmButton(
                      backgroundColor: appColors.purple,
                      width: double.infinity,
                      height: 40,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      onPressed: mainButtonPressed ?? () => Navigator.pop(context),
                      text: mainButtonLabel ?? '',
                    ),
                  )
                : Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        if (showSubButton!)
                          Expanded(
                            child: SlopeCancelButton(
                              text: subButtonLabel ?? '',
                              height: 40,
                              width: double.infinity,
                              backgroundColor: appColors.lightGray,
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              textStyle: TextStyle(
                                  color: appColors.textDetail,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              onPressed: subButtonPressed ?? () => Navigator.pop(context),
                            ),
                          ),
                        if (showSubButton!)
                          const SizedBox(
                            width: 12,
                          ),
                        if (showMainButton!)
                          Expanded(
                            child: SlopeConfirmButton(
                              backgroundColor: appColors.purple,
                              width: double.infinity,
                              height: 40,
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                              onPressed: mainButtonPressed ?? () => Navigator.pop(context),
                              text: mainButtonLabel ?? '',
                            ),
                          )
                      ],
                    ),
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
