import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/pages/profile/mnemonic_backup/view/wallet_tips_item.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
import 'package:wallet/widgets/button/app_back_button.dart';

class ExportTipsPage extends StatefulWidget {
  final WalletEntity entity;
  const ExportTipsPage({Key? key, required this.entity}) : super(key: key);
  @override
  _ExportTipsPageState createState() => _ExportTipsPageState();
}

class _ExportTipsPageState extends State<ExportTipsPage> {
  final List<String> tips = [
    "Obtaining the private key is equivalent to owning the wallet asset ownership. ",
    "Copy the Private Key with paper & pen, and keep it safe.",
    "IF you loss the private key, it cannot be retrieved.  Please keep it properly. ",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletBar.backWithTitle("Export Tips"),
      body: Padding(
        padding: EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.of(context).currentColors.dividerColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Read Following Information',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 20 / 16,
                        color:AppTheme.of(context).themeMode == ThemeMode.light ? Color(0xff292C33) : AppTheme.of(context).currentColors.textColor1),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: tips.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 16,
                    ),
                    itemBuilder: (context, index) {
                      return WalletTipsItem(tips: tips[index]);
                    },
                  ),
                  SizedBox(
                    height: 16
                  )
                ],
              ),
            ),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SafeArea(
      child: Container(
        color: AppTheme.of(context).currentColors.backgroundColor,
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 56,
                margin: EdgeInsets.only(bottom: 6),
                child: TextButton(
                  child: Text(
                    'Start Backup',
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
                    service.router.pushNamed(
                        RouteName.exportKeyPage,
                        arguments: widget.entity);
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: 56,
                child: TextButton(
                  child: Text(
                    'Later',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.of(context).currentColors.textColor2),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () async {
                    service.router.pop();
                    service.router.pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
