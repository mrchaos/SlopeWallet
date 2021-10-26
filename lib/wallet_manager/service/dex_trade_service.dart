import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:slope_solana_client/src/dex/balances.dart';
import 'package:slope_solana_client/src/dex/fills.dart';
import 'package:slope_solana_client/src/dex/order.dart';
import 'package:slope_solana_client/src/sol/solana_account.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:cryptography/cryptography.dart' as crypto;

// String privateKey; //
// String address; //
// String mnemonic; //
// String walletId; // id()
// String walletName; //
// String blockChain; //
// List<CoinEntity> coins; //
/// dex
abstract class DexTradeService {

  Future<MySolanaAccount> _getSolanaAccount(WalletEntity wallet) async {
    var keyPair = await _generateKeyPairByPrivateKey(wallet.decryptPrivateKey());
    MySolanaAccount solanaAccount = MySolanaAccount(1, wallet.decryptPrivateKey(), wallet.address, keyPair, "SOL");
    return solanaAccount;
  }


  Future<crypto.KeyPair> _generateKeyPairByPrivateKey(String privateKey) async {
    return MySolanaWallet().generateSOLKeyPairByPrivateKey(privateKey);
  }

  Future<MySolanaAccount> getSolanaAccount (WalletEntity wallet) async {
    var keyPair = await _generateKeyPairByPrivateKey(wallet.decryptPrivateKey());
    MySolanaAccount solanaAccount = MySolanaAccount(1, wallet.decryptPrivateKey(), wallet.address, keyPair, "SOL");
    return solanaAccount;
  }

  // Future<MySolanaAccount> getSolanaAccount (WalletEntity wallet) async {
  //   var keyPair = await _generateKeyPairByPrivateKey(wallet.decryptPrivateKey());
  //   MySolanaAccount solanaAccount = MySolanaAccount(1, wallet.decryptPrivateKey(), wallet.address, keyPair, "SOL");
  //   return solanaAccount;
  // }


  ///
  /// [wallet]
  /// [marketPair] , etc: BTC/USDT
  Future<List<Balances>> getTradeAccountBalance(
      WalletEntity wallet, String marketPair) async {
    MySolanaAccount solanaAccount = await _getSolanaAccount(wallet);
    return await DexTrade().getTradeAccountBalance(solanaAccount, marketPair);
  }



  ///
  /// [wallet]
  /// [marketPair] , etc: BTC/USDT
  Future<List<Fills>> getRecentTradeHistory(
      WalletEntity wallet, String marketPair) async {
    MySolanaAccount solanaAccount = await _getSolanaAccount(wallet);
    return await DexTrade().getRecentTradeHistory(solanaAccount, marketPair);
  }

  ///
  /// [wallet]
  /// [marketPair] , etc: BTC/USDT
  Future<List<Order>> getOpenOrders(
      WalletEntity wallet, String marketPair) async {
    MySolanaAccount solanaAccount = await _getSolanaAccount(wallet);
    return await DexTrade().getOpenOrders(solanaAccount, marketPair);
  }

  ///
  /// [wallet]
  /// [marketPair] , etc: BTC/USDT
  /// [orders]
  Future<TxSignature?> cancelOrder(
      WalletEntity wallet, String marketPair, List<Order> orders) async {
    MySolanaAccount solanaAccount = await _getSolanaAccount(wallet);
    return await DexTrade().cancelOrder(solanaAccount, marketPair, orders);
  }

  /// [wallet]
  /// [marketPair] , etc: BTC/USDT
  /// [splAddress] (SOL,solana()), etc: BTC
  /// [fiatAddress] , etc: USDT
  Future<List<TxSignature>?> settle(WalletEntity wallet, String marketPair, String splAddress,
      String fiatAddress) async {
    MySolanaAccount solanaAccount = await _getSolanaAccount(wallet);
    return await DexTrade()
        .settle(solanaAccount, marketPair, splAddress, fiatAddress);
  }

  ///
  /// [wallet]
  /// [marketPair] , etc: BTC/USDT
  /// [side] 'buy' | 'sell'
  /// [size]
  /// [orderType] 'ioc' | 'postOnly' | 'limit'
  /// [splAddress]  PublicKey | undefined;   , sol，，
  /// [fiatAddress] PublicKey | undefined;  , sol，，
  Future<TxSignature?> trade(
      WalletEntity wallet,
    String marketPair,
    String side,
    num price,
    num size,
    String orderType, {
    String? splAddress,
    String? fiatAddress,
  }) async {
    MySolanaAccount solanaAccount = await _getSolanaAccount(wallet);
    return await DexTrade()
        .trade(solanaAccount, marketPair, side, price, size, orderType, splAddress: splAddress, fiatAddress: fiatAddress);
  }

  /// /settle
  Future<SignatureStatus?> checkSignature(List<TxSignature> txSignatures) async{
      return await DexTrade().checkSignature(txSignatures);
  }


  /// price/size
  /// [marketPair] , etc: BTC/USDT
  /// return List<num> price, size
  Future<List<num>?> getTradeAccuracy(String marketPair) async {
    return await DexTrade().getTradeAccuracy(marketPair);
  }
}
