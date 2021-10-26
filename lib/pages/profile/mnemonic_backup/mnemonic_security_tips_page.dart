import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/pages/profile/mnemonic_backup/view/wallet_tips_item.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';
// verb ocean lady claim bread acoustic tray spell leave ship couple bless
class MnemonicSecurityTipsPage extends StatefulWidget {
  final WalletEntity entity;

  const MnemonicSecurityTipsPage({Key? key, required this.entity})
      : super(key: key);

  @override
  _MnemonicSecurityTipsPageState createState() =>
      _MnemonicSecurityTipsPageState();
}

class _MnemonicSecurityTipsPageState extends State<MnemonicSecurityTipsPage> {

  final List<String> tips = [
    "Without backing up mnemonic words, assets will not be secure.",
    "Mnemonic has the same value as your bank card number & password, obtaining the mnemonic is equivalent to obtaining your Pole wallet assets.",
    "Make sure backup in a safe environment with no cameras and no one around.",
    "Do not send your mnemonic to anyone, include the staff member.",
    "If your phone got loss, damage, or uninstall App, you can use mnemonic to restore your Slope Wallet."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WalletBar.backWithTitle("Mnemonic Security Tips"),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                margin: EdgeInsets.only(top: 24),
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.of(context).currentColors.dividerColor, width: 1),
                    borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Container(
                      alignment: kIsWeb ? Alignment.centerLeft : Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8,bottom: 16),
                        child: Text(
                          'Read Following Information',
                          style: TextStyle(
                              color:
                              AppTheme.of(context).currentColors.textColor1,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    ListView.separated(
                      padding: EdgeInsets.zero,
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
                  ],
                ),
              ),
            ),
          )),
          _buildBottom()
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SafeArea(
      child: Container(
        color: AppTheme.of(context).currentColors.backgroundColor,
        child: Padding(
          padding:
          const EdgeInsets.only(left: 24, right: 24,),
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
                      service.router.pushNamed(RouteName.mnemonicBackupPage,
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
      ),
    );
  }
}
