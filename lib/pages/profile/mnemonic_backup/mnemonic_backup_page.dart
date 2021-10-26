import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screen_shot_listen_plugin/screen_shot_listen_plugin.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/create_wallet/model/wallet_create_model.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/create_wallet/view/mnemonic_word_item.dart';
import 'package:wallet/pages/create_wallet/view/screenshot_dialog.dart';
import 'package:wallet/pages/profile/mnemonic_backup/view/backup_mark_item.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/Dialog/public_dialog.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:collection/collection.dart';
import 'package:wallet/widgets/tools.dart';

class MnemonicBackupPage extends StatefulWidget {
  final WalletEntity entity;

  const MnemonicBackupPage({Key? key, required this.entity}) : super(key: key);

  @override
  _MnemonicBackupPageState createState() => _MnemonicBackupPageState();
}

class _MnemonicBackupPageState extends State<MnemonicBackupPage> {
  late WalletCreateModel _model;

  List<String> icons = [
    Assets.assets_svg_wallet_no_camera_svg,
    Assets.assets_svg_wallet_no_wifi_svg,
    Assets.assets_svg_wallet_no_person_svg,
    Assets.assets_svg_wallet_paper_pencil_svg
  ];
  List<String> marks = [
    "NO Camera / Screenshots",
    "Do not use network transmission",
    "Do not tell anyone",
    "Record with paper and pencil"
  ];

  bool _showNext = true;

  @override
  void initState() {
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

  void _screenShotListener(String path) {
    if (isScreenShotDialogShow) return;
    ScreenShotDialog.show(context);
  }

  void _noPermissionListener() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    _model = WalletCreateModel.instance
      ..initMnemonic(widget.entity.decryptMnemonic());
    return Scaffold(
      appBar: WalletBar.backWithTitle("Backup Mnemonic"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24).copyWith(top: 24),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  kIsWeb ? _buildWebMnemonic() : _buildMnemonic(),
                  GridView.count(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.5,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: List.generate(
                        marks.length,
                        (index) => BackupMarkItem(
                              svg: icons[index],
                              mark: marks[index],
                            )),
                  ),
                ],
              ),
            )),
            _buildNext()
          ],
        ),
      ),
    );
  }

  Widget _buildNext() {
    return Visibility(
      visible: _showNext,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: 56,
          margin: EdgeInsets.only(bottom: 16),
          child: TextButton(
            child: Text(
              'Next',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
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
              _stopListenScreenShot();
              await service.router
                  .pushNamed(RouteName.mnemonicVerificationPage, arguments: [true, WalletCreateRelatedData()]);
              await Future.delayed(Duration(milliseconds: 500));
              _startListenScreenShot();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMnemonic() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: AppTheme.of(context).currentColors.dividerColor, width: 1),
          borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ).copyWith(bottom: 15),
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            height: 44,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 24,
                  // height: 44,
                  child: Text(
                    'Read Following Information',
                    style: TextStyle(
                        color: AppTheme.of(context).currentColors.textColor1,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 19,
                  child: TextButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(0, 0)),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap
                    ),
                    onPressed: () {
                      _showPrompt();
                    },
                    child: Container(
                      width: 16,
                      height: 16,
                      // padding: EdgeInsets.all(4.5),
                      alignment: Alignment.topRight,
                      child: service.svg.asset(
                        Assets.assets_svg_wallet_grey_warning_svg,
                      ),
                    ),
                  ),
                )
              ],
            ),
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
        ],
      ),
    );
  }

  Widget _buildWebMnemonic() {
    return Builder(
      builder: (context) {
        WalletCreateModel _model = context.watch<WalletCreateModel>();
        List<Widget> mnemonicChild;
        var createList = _model.mnemonicMap.entries
            .map((e) => MapEntry(int.parse(e.key), e.value))
            .sorted((a, b) => a.key.compareTo(b.key))
            .map((e) => e.value)
            .toList();
        final mnemonic = createList.fold("", (p, e) => '$p$e ').trim();
        mnemonicChild = [
          SelectableText(
            mnemonic,
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
        return Column(
          children: [
            Row(
              children: [
                Text(
                  'Mnemonic Created',
                  style: TextStyle(
                      color: AppTheme.of(context).currentColors.textColor1,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    _showPrompt();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    padding: EdgeInsets.all(4.5),
                    alignment: Alignment.center,
                    child: service.svg.asset(
                      Assets.assets_svg_wallet_grey_warning_svg,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xfff3f3f5), width: 1),
                  borderRadius: BorderRadius.circular(16)),
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              constraints: BoxConstraints(minHeight: 140),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: mnemonicChild,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPrompt() async {
    setState(() {
      _showNext = false;
    });
    await showAlertVerticalButtonDialog(
        mainButtonPressed: () async {
          Navigator.pop(context);
        },
        context: context,
        showSubButton: false,
        barrierColor: Colors.black.withOpacity(0.4),
        mainButtonLabel: "Done",
        title: "Prompt information",
        content:
            "Please backup your mnemonic properly to restore your Slope Wallet.Slope Wallet does not save mnemonic words for you.Please record your mnemonic words in order.");
    setState(() {
      _showNext = true;
    });
  }
}
