import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/profile/mnemonic_backup/view/backup_mark_item.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/Dialog/public_dialog.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/loading/loading_util.dart';

class ExportKeyPage extends StatefulWidget {
  final WalletEntity entity;

  const ExportKeyPage({Key? key, required this.entity}) : super(key: key);

  @override
  _ExportKeyPageState createState() => _ExportKeyPageState();
}

class _ExportKeyPageState extends State<ExportKeyPage> {
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

  late String _privateKey = "";

  @override
  void initState() {
    _privateKey = widget.entity.decryptPrivateKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletBar.backWithTitle('Export Tips'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              Positioned.fill(
                  child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQueryData.fromWindow(window).padding.bottom +
                        56 +
                        10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppTheme.of(context).currentColors.dividerColor, width: 1),
                          borderRadius: BorderRadius.circular(16)),
                      padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
                      margin: EdgeInsets.only(bottom: 16, top: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ..._buildTips(),
                          _buildPrivateKey(),
                        ],
                      ),
                    ),
                    _buildSaveWarning(),
                  ],
                ),
              )),
              _buildDone(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTips() {
    return [
      Text('Private Key Exported',
          style: TextStyle(
              color: AppTheme.of(context).currentColors.textColor1,
              fontSize: 16,
              fontWeight: FontWeight.w500)),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text(
          'Please back up your private key properly to restore your Slope wallet ! Slope wallet will not save your private key.',
          style: TextStyle(
            color: AppTheme.of(context).currentColors.textColor2,
            fontSize: 14,
          ),
          strutStyle: StrutStyle(fontSize: 18),
        ),
      ),
    ];
  }

  Widget _buildPrivateKey() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.of(context).themeMode == ThemeMode.light ? AppTheme.of(context).currentColors.lightGray : AppTheme.of(context).currentColors.darkLightGray2,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              _privateKey,
              style: TextStyle(
                color: AppTheme.of(context).currentColors.textColor3,
                fontSize: 12,
              ),
              strutStyle: StrutStyle(leading: 0.3),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12),
            child: InkWell(
              onTap: _showCopyWarning,
              child: Container(
                width: 20,
                height: 20,
                // padding: EdgeInsets.all(4.5),
                child: service.svg.asset(
                  Assets.assets_svg_wallet_copy_icon_svg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveWarning() {
    return GridView.count(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      childAspectRatio: 2.9,
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
    );
  }

  Widget _buildDone() {
    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      height: 56,
      child: Container(
        width: double.infinity,
        child: TextButton(
          child: Text(
            'Done',
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
            showAlertVerticalButtonDialog(
                mainButtonPressed: () {
                  service.router.pop();
                  service.router.pop();
                  service.router.pop();
                  service.router.pop();
                  // if(config.app.appType == WalletAppType.slope){
                  //   service.router.pop();
                  //   service.router.pop();
                  //   service.router.pop();
                  //   service.router.pop();
                  // }else{
                  //   service.router
                  //       .popUntil(ModalRoute.withName(RouteName.navigationPage));
                  // }
                },
                context: context,
                showSubButton: false,
                barrierColor: Colors.black.withOpacity(0.4),
                mainButtonLabel: "Done",
                title: "Export Success",
                content:
                    "Your Private Key exported successful ! Please keep your Private Key properly !");
          },
        ),
      ),
    );
  }

  void _showCopyWarning() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: AppTheme.of(context).currentColors.backgroundColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
            ),
            child: ListView(
              padding: EdgeInsets.only(
                  top: 20,
                  bottom: MediaQueryData.fromWindow(window).padding.bottom,
                  left: 20,
                  right: 20),
              shrinkWrap: true,
              children: [
                Text(
                  "Copy Private Key",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.of(context).currentColors.textColor1,
                    fontSize: 18,
                  ),
                  strutStyle: StrutStyle(fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                service.svg.asset(Assets.assets_svg_wallet_red_warning_svg),
                SizedBox(
                  height: 12,
                ),
                Text("Risk Warning",  textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFF0665B), fontSize: 14),),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Copy Private key has a risk that the clipboard is easily monitored or abused by third-party applications; it is recommended to use hand-writing to copy it down.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.of(context).currentColors.textColor2,
                    fontSize: 14,
                  ),
                  strutStyle: StrutStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 58,
                  // color: Colors.redAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Clipboard.setData(
                                  ClipboardData(text: _privateKey));
                              showToast("The private key has been copied!");
                            },
                            child: Text(
                              'Copy Anyway',
                              style: TextStyle(
                                  color: AppTheme.of(context)
                                      .currentColors
                                      .textColor1,
                                  fontSize: 16),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppTheme.of(context).themeMode == ThemeMode.light ? AppTheme.of(context).currentColors.lightGray : AppTheme.of(context).currentColors.dexCreateBtn),
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Container(
                          height: 48,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Don't Copy",
                              style: TextStyle(
                                  color: AppTheme.of(context)
                                      .currentColors
                                      .textColor1,
                                  fontSize: 16),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppTheme.of(context).themeMode == ThemeMode.light ?  AppTheme.of(context).currentColors.lightGray : AppTheme.of(context).currentColors.dexCreateBtn),
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
