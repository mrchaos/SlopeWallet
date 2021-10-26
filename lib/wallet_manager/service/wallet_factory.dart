import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';

class WalletFactory {
  WalletFactory._();

  /// solana
  static Future<WalletEntity> solanaWallet() async {
//todo
  }

  static Future<WalletEntity> solanaWalletImport(
      {required String mnemonic,
      SolanaWalletPath path = SolanaWalletPath.m44_501_0_0}) async {
    //todo
  }

  static Future<WalletEntity> solanaWalletImportByPrivateKey(
      String privateKey) async {
    //todo
  }
}
