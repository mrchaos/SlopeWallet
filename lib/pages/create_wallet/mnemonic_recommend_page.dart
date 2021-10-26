import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/pages/create_wallet/model/wallet_create_model.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/widgets/app_bar/wallet_bar.dart';

class MnemonicRecommendPage extends StatefulWidget {
  final WalletCreateRelatedData pageData;
  const MnemonicRecommendPage({Key? key, required this.pageData})
      : super(key: key);

  @override
  _MnemonicRecommendPageState createState() => _MnemonicRecommendPageState();
}

class _MnemonicRecommendPageState extends State<MnemonicRecommendPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: WalletBar.backWithTitle(config.app.appType != WalletAppType.slope
          ? WalletCreateModel().isFirstWallet
              ? "Slope Wallet"
              : "Create New Wallet"
          : ""),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ..._buildIconAndSubTitle(),
                    _buildBorderTips(),
                  ],
                ),
              ),
              _buildNextAndSkip(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildIconAndSubTitle() {
    return [
      Padding(
        padding: EdgeInsets.only(top: 32, bottom: 32),
        child: Text(
          'Backup Your Mnemonic',
          style: TextStyle(
              color: AppTheme.of(context).currentColors.textColor1,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  Widget _buildBorderTips() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: AppTheme.of(context).currentColors.dividerColor, width: 1),
          borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Text(
            'We strongly recommend backing up your Mnemonic',
            style: TextStyle(
                color: AppTheme.of(context).currentColors.textColor1,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'If your device is damaged, lost, stolen, or inaccessible.\nMnemonic are the only way to help you recover your wallet.',
            style: TextStyle(
              color: AppTheme.of(context).currentColors.textColor2,
              fontSize: 14,
            ),
            strutStyle: StrutStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildNextAndSkip() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 56,
            margin: EdgeInsets.only(bottom: 6),
            child: TextButton(
              child: Text(
                'Back up',
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
                service.router.pushNamed(RouteName.mnemonicSavePage, arguments: widget.pageData);
              },
            ),
          ),

        ],
      ),
    );
  }
}
