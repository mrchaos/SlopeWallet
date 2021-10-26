

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/widgets/Dialog/public_dialog.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:collection/collection.dart';
class WalletImportModel {

  final List<String> walletPaths = [
    SolanaWalletPath.m44_501_0.value,
    SolanaWalletPath.m44_501_0_0.value,
    SolanaWalletPath.m_501_0_0_0.value
  ];

  final Map<String, SolanaWalletPath> walletPathMap = {
    SolanaWalletPath.m44_501_0.value: SolanaWalletPath.m44_501_0,
    SolanaWalletPath.m44_501_0_0.value: SolanaWalletPath.m44_501_0_0,
    SolanaWalletPath.m_501_0_0_0.value: SolanaWalletPath.m_501_0_0_0
  };
  String errStr = "No related words";
  late WalletCreateRelatedData pageData;
  late ValueNotifier<bool> _inputValidateNotifier;
  WalletImportModel(WalletCreateRelatedData pageData, ValueNotifier<bool> inputValidateNotifier) {
    this.pageData = pageData;
    this._inputValidateNotifier = inputValidateNotifier;
  }

  WalletEntity? walletEntity;

  void mnemonicImport(BuildContext context, String inputText, String walletName, SolanaWalletPath path) async{
   //todo import  mnemonic

  }

  void privateKeyImport(BuildContext context, String inputText, String walletName) async{
   //todo import private key
  }

  void _showPrompt(BuildContext context) async {
    await showAlertVerticalButtonDialog(
        mainButtonPressed: () async {
          Navigator.pop(context);
          if(pageData.isSetupPassword){
            service.router.pushReplacementNamed(RouteName.walletPasswordPage,
                arguments: pageData.copyWith(isSetupPassword: true, wallet: walletEntity,  backPopPageCount: pageData.backPopPageCount + 2));
          } else {
            service.router.pop();
          }
        },
        context: context,
        showSubButton: false,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.4),
        mainButtonLabel: "Done",
        title: "Import Success",
        content: "You have successfully imported your Slope Wallet.");
  }

}
