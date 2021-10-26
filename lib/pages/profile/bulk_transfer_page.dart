import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallet/common/util/number_precision/number_precision.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/wallet_manager/wallet_encrypt.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/loading/loading_util.dart';

class BulkTransferPage extends StatefulWidget {
  const BulkTransferPage({Key? key}) : super(key: key);

  @override
  _BulkTransferPageState createState() => _BulkTransferPageState();
}

class _BulkTransferPageState extends State<BulkTransferPage> {
  TextEditingController _ctrl = TextEditingController();
  TextEditingController _solCtrl = TextEditingController();
  TextEditingController _tokenCtrl = TextEditingController();

  //
  bulkFun() {
    //
    List<String> accountList = _ctrl.text.split('\n').toList();
    // Sol
    String _solCounts = '0.0012';//_solCtrl.text;

    // usdc
    String _tokenCounts = '1';//_tokenCtrl.text;

    //
    int _index = 0;
    accountList.forEach((sAccount) {
      if (null != WalletMainModel.instance.currentWallet) {
        //
        WalletEntity _walletEntity = WalletMainModel.instance.currentWallet!;
        CoinEntity _coinEntity = _walletEntity.coins.first;
        _coinEntity.splAddress = _walletEntity.address;
        int _lamports =
            NP.times(_solCounts, pow(10, _coinEntity.decimals)).toInt();
        bool solResult = transferFun(sAccount, _lamports, _coinEntity);
        if (!solResult) {
          print('${_index + 1}！');
          showToast('${_index + 1}！');
          return;
        }

        CoinEntity _tokenEntity = _walletEntity.coins[1];
        int _tokenNumber =
            NP.times(_tokenCounts, pow(10, _coinEntity.decimals)).toInt();
        bool tokenResult = transferFun(sAccount, _tokenNumber, _tokenEntity);
        if (!tokenResult) {
          print('${_index + 1}！');
          showToast('${_index + 1}！');
          return;
        }
        _index++;
      }
    });

  }

  //
  bool transferFun(String sAccount, int lamports, CoinEntity coinEntity) {
    if( null == WalletMainModel.instance.currentWallet)  return false;
    //
    WalletEntity _walletEntity =
        WalletMainModel
            .instance.currentWallet!;


    final String prKey =
    WalletEncrypt.aesDecrypt(
        _walletEntity.privateKey,
        walletManager.aesKey);

    if (coinEntity.isSOL) {
      WalletMainModel()
          .transferAccounts(
          fromAddress: coinEntity.splAddress,
          toAddress: sAccount,
          privateKey: _walletEntity
              .decryptPrivateKey(),
          lamports: lamports);
      return true;
    }


    try {
      WalletMainModel.instance
          .transfer(
          privateKey: prKey,
          walletAddress: sAccount,
          source: coinEntity.splAddress,
          mintAddressSend: coinEntity
              .contractAddress,
          lameports: lamports,
          decimals:coinEntity.decimals);
    } catch (e) {
      return false;
    }
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulk Transfer'),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            TextField(
              controller: _ctrl,
              autocorrect: false,
              enableSuggestions: false,
              onChanged: (value) {},
              maxLines: 10,
              style: TextStyle(
                  height: 1.5,
                  fontSize: 14,
                  color: AppTheme.of(context).currentColors.textColor1),
              cursorHeight: 20,
              decoration: InputDecoration(
                hintText: 'Please enter transfer list',
                hintStyle: TextStyle(
                  height: 21 / 14,
                  fontSize: 14,
                  color: AppTheme.of(context).currentColors.textColor4,
                ),
                contentPadding:
                    EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 12),
                border: InputBorder.none,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _solCtrl,
              keyboardType: TextInputType.number,
              autocorrect: false,
              enableSuggestions: false,
              maxLines: 1,
              style: TextStyle(
                  height: 1.5,
                  fontSize: 14,
                  color: AppTheme.of(context).currentColors.textColor1),
              cursorHeight: 20,
              decoration: InputDecoration(
                hintText: 'Please enter sol counts',
                hintStyle: TextStyle(
                  height: 21 / 14,
                  fontSize: 14,
                  color: AppTheme.of(context).currentColors.textColor4,
                ),
                contentPadding:
                    EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 12),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppTheme.of(context).currentColors.dividerColor,
                )),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: _tokenCtrl,
              keyboardType: TextInputType.number,
              autocorrect: false,
              enableSuggestions: false,
              maxLines: 1,
              style: TextStyle(
                  height: 1.5,
                  fontSize: 14,
                  color: AppTheme.of(context).currentColors.textColor1),
              cursorHeight: 20,
              decoration: InputDecoration(
                hintText: 'Please enter usdc counts',
                hintStyle: TextStyle(
                  height: 21 / 14,
                  fontSize: 14,
                  color: AppTheme.of(context).currentColors.textColor4,
                ),
                contentPadding:
                    EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 12),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: AppTheme.of(context).currentColors.dividerColor,
                )),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextButton(onPressed: ()=> bulkFun(), child: Text('Send')),
          ],
        ),
      ),
    );
  }
}
