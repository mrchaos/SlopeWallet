import 'package:flutter/foundation.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/module/wallet_module.dart';
import 'package:wallet/pages/create_wallet/model/wallet_create_model.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/wallet_manager/database/wallet_database.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wd_common_package/wd_common_package.dart';

class WalletDataCenter extends ViewModel{
  factory WalletDataCenter() => _getInstance();
  static WalletDataCenter get instance => _getInstance();
  static WalletDataCenter? _instance;
  static WalletDataCenter _getInstance() => _instance ?? WalletDataCenter._();
  WalletDataCenter._();

  /// 
  List<WalletEntity> allWallets = [];

  /// 
  WalletEntity _currentWallet = WalletEntity();
  WalletEntity get currentWallet => _currentWallet;
  set currentWallet(WalletEntity value) {
    _currentWallet = value;
    notifyListeners();
    // totalBalance = 0;
    // if(!_isFirstAppear){_refreshCurrentWalletBalance();}
  }
  /// 
  Future queryAllWallets() async {
    _currentWallet = WalletEntity();
    allWallets.clear();
    var res = await walletDatabase.queryAllWallet();
    // res.forEach((element) {
    //   allWallets.add(element..initUI(element));
    // });
    allWallets.addAll(res);
    if (allWallets.length > 0) currentWallet = allWallets.first;
    return allWallets;
  }


  Future addWallet(WalletEntity entity) async {
    var res =  await walletDatabase.insertWallet(walletEntity: entity);
    if(kIsWeb && (res is String)){
      entity.walletId = res;
    }
    allWallets.add(entity
      ..init()
      ..initUI(entity));
    notifyListeners();
    return Future.value();
  }

  Future deleteWallet(WalletEntity entity) async {
    await walletDatabase.deleteWallet(
        walletEntity: entity);
    allWallets
        .removeWhere((element) => element.walletName == entity.walletName);

    //
    notifyListeners();
    return Future.value();
  }

  Future updateWallet(WalletEntity entity) async {
    await walletDatabase.updateWallet(walletEntity: entity);
    notifyListeners();
    return Future.value();
  }

}
