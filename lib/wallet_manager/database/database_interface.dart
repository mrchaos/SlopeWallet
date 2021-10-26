


import 'package:wallet/wallet_manager/data/wallet_entity.dart';

abstract class WalletDatabaseInterface {
  /// 
  Future<dynamic> insertWallet({required WalletEntity walletEntity});
  /// 
  Future<int> deleteWallet({required WalletEntity walletEntity});
  /// 
  ///
  /// [walletEntity]
  Future<int> updateWallet({required WalletEntity walletEntity});

  /// 
  Future<List<WalletEntity>> queryAllWallet();

  /// blockChain
  Future<List<WalletEntity>> queryWalletByBlockChain(
      {required String blockChain});

  /// (,)
  Future<List<WalletEntity>> queryWalletByMnemonic({required String mnemonic});

  /// walletId
  Future<WalletEntity?> queryWalletByWalletId({required String walletId});

  /// walletName
  Future<WalletEntity?> queryWalletByWalletName({required String walletName});

  /// walletName
  ///
  /// true, false
  Future<bool> checkWalletNameIsExist({required String walletName});

  /// wallet
  /// [aesPrivateKey]: 
  /// true, false
  Future<bool> checkWalletIsExist({required String aesPrivateKey});

  Future deleteAllWallet();
}
