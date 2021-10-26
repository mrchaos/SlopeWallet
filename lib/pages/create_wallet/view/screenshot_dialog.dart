import 'package:flutter/material.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/tools.dart';
import 'package:provider/provider.dart';
bool isScreenShotDialogShow = false;

class ScreenShotDialog extends StatefulWidget {
  static show(BuildContext context) async {
    isScreenShotDialogShow = true;
    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: context.read<AppTheme>().currentColors.barrierColor,
      builder: (c) => WillPopScope(
        onWillPop: () => Future.value(true),
        child: ScreenShotDialog(),
      ),
    );
    isScreenShotDialogShow = false;
  }

  @override
  _ScreenShotDialogState createState() => _ScreenShotDialogState();
}

class _ScreenShotDialogState extends State<ScreenShotDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 289,
        height: 254,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: AppTheme.of(context).currentColors.backgroundColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            service.svg.asset(Assets.assets_svg_screenshot_warning_svg,
                width: 60, height: 60),
            SizedBox(height: 8),
            Text(
              "Warning",
              style: TextStyle(
                  color: AppTheme.of(context).currentColors.textColor1,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 22 / 18),
            ),
            SizedBox(height: 10),
            Text(
              "Screenshots may cause your mnemonic words to leak and cause loss of tokens, please save them carefully！",
              style: TextStyle(
                  color: AppTheme.of(context).currentColors.textColor2,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 18 / 14),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 20 / 16),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      AppTheme.of(context).currentColors.purpleAccent),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
                ),
                onPressed: () async {
                  service.router.pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
