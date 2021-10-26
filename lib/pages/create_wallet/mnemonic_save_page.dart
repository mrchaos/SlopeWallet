import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screen_shot_listen_plugin/screen_shot_listen_plugin.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/create_wallet/model/wallet_create_model.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/create_wallet/view/mnemonic_word_item.dart';
import 'package:wallet/pages/create_wallet/view/screenshot_dialog.dart';
import 'package:wallet/pages/navigation_page.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/tools.dart';

class MnemonicSavePage extends StatefulWidget {
  final WalletCreateRelatedData pageData;

  const MnemonicSavePage({Key? key,required this.pageData}) : super(key: key);
  @override
  _MnemonicSavePageState createState() => _MnemonicSavePageState();
}

class _MnemonicSavePageState extends State<MnemonicSavePage> {

  late WalletCreateModel _model;
  @override
  void initState() {
    _model = WalletCreateModel()..initMnemonic(widget.pageData.wallet!.mnemonic);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _startListenScreenShot();
    });
    super.initState();
  }
  @override
  void dispose() {
   _stopListenScreenShot();
    super.dispose();
  }

  void _startListenScreenShot() {
    ScreenShotListenPlugin.instance
      ..startListen()
      ..addScreenShotListener(_screenShotListener)
      ..addNoPermissionListener(_noPermissionListener);
  }

  void _stopListenScreenShot() {
    ScreenShotListenPlugin.instance.screenShotListener = null;
    ScreenShotListenPlugin.instance.noPermissionListener = null;
    ScreenShotListenPlugin.instance.stopListen();
  }


  void _screenShotListener(String path){
    if(isScreenShotDialogShow) return;
    ScreenShotDialog.show(context);
  }
  void _noPermissionListener() {
    Permission.storage.request();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletBar.backWithTitle(config.app.appType != WalletAppType.slope
          ? _model.isFirstWallet
              ? "Slope Wallet"
              : "Create New Wallet"
          : ""),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQueryData.fromWindow(window).padding.bottom +
                        56 +
                        21),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._buildTips(),
                    _buildMnemonic(),
                  ],
                ),
              )),
              _buildNext()
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTips() {
    return [
      Padding(
        padding: EdgeInsets.only(top: 24, bottom: 16),
        child: Text(
          'Your Mnemonic',
          style: TextStyle(
              color: AppTheme.of(context).currentColors.textColor1,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      Text(
        'Write down the Mnemonic words in order. Save it properly.',
        style: TextStyle(
          color: AppTheme.of(context).currentColors.textColor1,
          fontSize: 14,
        ),
        strutStyle: StrutStyle(fontSize: 22),
      ),
      Container(
        decoration: BoxDecoration(
          color: AppTheme.of(context).currentColors.redAccent.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        height: 40,
        margin: EdgeInsets.symmetric(vertical: 16),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            service.svg.asset(
              Assets.assets_svg_wallet_red_warning_border_svg,
              width: 24,
              height: 24,
            ),
            SizedBox(
              width: 4
            ),
            Text(
              "Do not divulge to third parties.",
              style: TextStyle(
                color: AppTheme.of(context).currentColors.redAccent,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    ];
  }

  Widget _buildMnemonic() {
    return Builder(
      builder: (context) {
        List<Widget> mnemonicChild;
        if (kIsWeb) {
          var createList = _model.mnemonicMap.entries
              .map((e) => MapEntry(int.parse(e.key), e.value))
              .sorted((a, b) => a.key.compareTo(b.key))
              .map((e) => e.value)
              .toList();

          final mnemonic = createList.fold("", (p, e) => '$p$e ').trim();

          mnemonicChild = [
            SelectableText(
              mnemonic,
              // showCursor: true,
              cursorHeight: 14,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                wordSpacing: 8,
              ),
              strutStyle: const StrutStyle(
                height: 18 / 14,
                leading: 12 / 18,
              ),
            ),
          ];
        } else {
          mnemonicChild = [
            Text(
              'Mnemonic Words',
              style: TextStyle(
                  color: AppTheme.of(context).currentColors.textColor1,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            GridView.count(
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 2,
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(
                  _model.mnemonicMap.length,
                  (index) => MnemonicWordItem(
                        onTap: () {},
                        number: _model.mnemonicMap.keys.toList()[index],
                        word: _model.mnemonicMap.values.toList()[index],
                      )),
            ),
          ];
        }
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: AppTheme.of(context).themeMode == ThemeMode.light
                      ? Color(0xfff3f3f5)
                      : AppTheme.of(context).currentColors.dividerColor,
                  width: 1),
              borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.all(16),
          constraints: kIsWeb ? BoxConstraints(minHeight: 140) : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: mnemonicChild,
          ),
        );
      },
    );
  }

  Widget _buildNext() {
    return Builder(
      builder: (context) {
        return SafeArea(
          child: Container(
            width: double.infinity,
            height: 56,
            margin: EdgeInsets.only(bottom: 16),
            child: TextButton(
              child: Text(
                'Next',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    AppTheme.of(context).currentColors.purpleAccent),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0))),
              ),
              onPressed: () async {
                await _model.generateRandomWords();
                // service.router.pushNamed(RouteName.mnemonicVerificationPage, arguments: false);
                // （） for 
                DateTime birthday = DateTime(2021, 7, 7);
                DateTime nowTime = DateTime.now();
                final difference = nowTime.difference(birthday).inHours;
                if (difference >= 0) {
                  _stopListenScreenShot();
                await service.router.pushNamed(RouteName.mnemonicVerificationPage,
                      arguments: [false, widget.pageData]);
                // pop
                await Future.delayed(Duration(milliseconds: 500));
                  _startListenScreenShot();
                  return;
                }

                // ,.
                WalletCreateModel _createModel = WalletCreateModel();
                if (_createModel.isFirstWallet) {
                  service.router
                      .pushNamed(RouteName.walletPasswordPage, arguments: widget.pageData);
                } else {
                  bool success = await _createModel.saveWallet(context, widget.pageData);
                  if (success) {
                    service.router.pop();
                    service.router.pop();
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }
}


