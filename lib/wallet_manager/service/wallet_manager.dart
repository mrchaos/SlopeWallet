import 'dart:convert';

import 'package:bip39/bip39.dart' as bip39;
import 'package:cryptography/cryptography.dart' as crypto;
import 'package:flutter/cupertino.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:slope_solana_client/src/comm/extensions.dart';
import 'package:slope_solana_client/src/sol/account_meta.dart';
import 'package:slope_solana_client/src/sol/instruction.dart';
import 'package:slope_solana_client/src/sol/instruction_message.dart';
import 'package:slope_solana_client/src/sol/instruction_message_send.dart';
import 'package:slope_solana_client/src/sol/instruction_signed_send_tx.dart';
import 'package:slope_solana_client/src/sol/instruction_signed_tx.dart';
import 'package:solana/src/types/json_rpc_error.dart';
import 'package:solana/src/util/solana_int_encoder.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/util/dispose_array/dispose_array.dart';
import 'package:wallet/common/util/number_precision/number_precision.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/wallet_manager/service/dex_trade_service.dart';
import 'package:wallet/wallet_manager/service/wallet_factory.dart';
import 'package:wallet/wallet_manager/service/wallet_pwd_service.dart';
import 'package:wd_common_package/wd_common_package.dart';

import '../database/wallet_database.dart';

final walletManager = WalletManager();

class WalletManager with WalletPWDService, DexTradeService {
  factory WalletManager() => _getInstance();

  static WalletManager get instance => _getInstance();
  static WalletManager? _instance;

  WalletManager._internal();

  static WalletManager _getInstance() {
    if (null == _instance) {
      _instance = WalletManager._internal();
    }
    return _instance!;
  }

  /// 
  /// [blockChain] 
  Future<WalletEntity> createWallet({
    String blockChain = BlockChains.sol,
  }) async {
    return WalletFactory.solanaWallet();
  }

  /// 
  ///
  /// [mnemonic] 
  /// [blockChain] 
  Future<WalletEntity> importWallet(
      {required String mnemonic,
      SolanaWalletPath path = SolanaWalletPath.m44_501_0_0,
      String blockChain = BlockChains.sol}) async {
    return WalletFactory.solanaWalletImport(mnemonic: mnemonic, path: path);
  }

  /// 
  ///
  /// [privateKey] 
  /// [blockChain] 
  Future<WalletEntity> importWalletByPrivateKey(
      {required String privateKey, String blockChain = BlockChains.sol}) async {
    return WalletFactory.solanaWalletImportByPrivateKey(privateKey);
  }

  /// SOL
  ///
  /// [sourceAddress] ()
  /// [destinationAddress] ()
  /// [privateKey] 
  /// [lamports] 
  Future<TxSignature> sendTransaction(
      {required String sourceAddress,
      required String destinationAddress,
      required String privateKey,
      required int lamports}) async {
    crypto.KeyPair keyPair = await _generateKeyPairByPrivateKey(privateKey);
    // blockhash
    Blockhash blockhash = await SolanaClient(config.net.solanaBaseUrl).getRecentBlockhash();
    Message message = Message.transfer(
        source: sourceAddress,
        destination: destinationAddress,
        lamports: lamports,
        recentBlockhash: blockhash);
    SignedTx st = await MySolanaWallet.signMessage(message, keyPair);
    return await SolanaClient(config.net.solanaBaseUrl).sendTransaction(st);
  }

  Future<void> waitForSignatureStatus(
    TxSignature signature, {
    TxStatus desiredStatus = TxStatus.finalized,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    return await SolanaClient(config.net.solanaBaseUrl).waitForSignatureStatus(
      signature,
      TxStatus.finalized,
      timeout: timeout,
    );
  }

  /// 
  ///
  /// [privateKey] 
  Future<crypto.KeyPair> _generateKeyPairByPrivateKey(String privateKey) async {
    return MySolanaWallet().generateSOLKeyPairByPrivateKey(privateKey);
  }

  /// （double，78，：2e-8）.
  /// ，：[errorDefaultValue]0
  ///
  /// [address] (, : base58.encode(publicKey))
  Future<double> getBalance(String address, {num? errorDefaultValue}) async {
    num result =
        await SolanaClient(config.net.solanaBaseUrl).getBalance(address).catchError((e) => -1);

    double coinSize;
    if (result != -1) {
      // SOLlamports
      num temp = NP.divide(result.toDouble(), LAMPORTS_PER_SOL);
      // coinSize = temp.truncated(6).toDouble();
      coinSize = temp.toDouble();
    } else {
      coinSize = (errorDefaultValue ?? 0).toDouble();
    }

    return coinSize;
  }

  // 。
  /// ，：[errorDefaultValue]0
  /// [address] (, : base58.encode(publicKey))
  Future<double> getTokenBalance(String address, {num? errorDefaultValue}) async {
    var result = await MySolanaClient(config.net.solanaBaseUrl)
        .getTokenBalance(address)
        .catchError((e) => -1);
    double coinSize;
    if (result != -1) {
      //
      // coinSize = result.truncated(6).toDouble();
      coinSize = result.toDouble();
    } else {
      coinSize = (errorDefaultValue ?? 0).toDouble();
    }
    return coinSize;
  }

  /// 
  ///
  /// [mnemonic] (' '3(12/24))
  bool validateMnemonic(String mnemonic) {
    var words = mnemonic.split(' ');
    if (words.length % 3 != 0) return false;
    return bip39.validateMnemonic(mnemonic);
  }

  /// 
  ///
  /// true, false
  Future<bool> validateWalletName({required String walletName}) async {
    bool isExist = await walletDatabase.checkWalletNameIsExist(walletName: walletName);
    return !isExist;
  }

  /// 
  ///
  /// true, false
  Future<bool> validateWallet({required String aesPrivateKey}) async {
    bool isExist = await walletDatabase.checkWalletIsExist(aesPrivateKey: aesPrivateKey);
    return !isExist;
  }

  /// 
  Future<void> saveWallet({required WalletEntity walletEntity}) async {
    return await walletDatabase.insertWallet(walletEntity: walletEntity);
  }

  Future<List<MyConfirmedTransactionWithTXID>> getTransactionsList(
    String address, {
    int limit = 10,
    String? beforeSignature,
    String? untilSignature,
  }) async {
    var result = await MySolanaClient(config.net.solanaBaseUrl)
        .getTransactionsListWithSpl(
          address,
          limit: limit,
          beforeSignature: beforeSignature,
          untilSignature: untilSignature,
        )
        .catchError((e) => <MyConfirmedTransactionWithTXID>[]);
    result.toList().retainWhere((t) => t != null);
    return result.toList().cast();
  }

  // Future<List<WalletProgramAccounts>> getProgramAccounts(
  //     String walletAddress) async {
  //   var data = await MySolanaClient('111').getAccountsNFTList(walletAddress);
  //   // return WalletProgramAccounts.fromJson(data);
  // }

  // 
  Future<String> createToken(String privateKey, String mintAddress, String walletAddress) async {
    logger.d(privateKey);
    var wallets = await _createToken(privateKey, mintAddress, walletAddress);
    logger.d(wallets);
    return wallets;
  }

  // SPL
  Future<bool> transfer({
    required String privateKey,
    String walletAddress = '',
    String source = '',
    String mintAddressSend = '',
    required int lameports,
    int decimals = 6,
  }) async {
    //todo
  }

  Instruction transferChecked({
    required String owner,
    required String source,
    required String destination,
    required String mintAddress,
    required int amount,
    required int decimals,
  }) {
   //todo
  }

  Instruction createAssociatedTokenAccountIx({
    required String fundingAddress,
    required String walletAddress,
    required String splTokenMintAddress,
    required String splAddress,
  }) {
    //todo
  }

  /// ，
  /// * [privateKey] 
  /// * [mint] mint
  /// * [source] 
  /// * [destination] SOL
  /// * [lameports]  （）
  /// * [decimals] 
  Future<bool> createAndTransferToAccount({
    required String privateKey,
    required String mint,
    required String source,
    required String destination,
    required int lameports,
    required int decimals,
  }) async {
   //todo
    return true;
  }

  // 
  Future<String> _createToken(String privateKey, String mintAddress, String walletAddress) async {
    //todo
    return splAddress;
  }

  static const OWNER_VALIDATION_PROGRAM_ID = '4MNPdKu9wFMvEeZBMt3Eipfs5ovVWTJb31pEXDJAAxX5';

  Instruction assertOwner({required String account, required String owner}) {
    final keys = [
      AccountMeta(address: account, isSigner: false, isWritable: false),
    ];
    return Instruction(
      accountIndices: keys,
      data: [
        ...List.filled(SystemProgram.programId.length, 0),
      ],
      programId: OWNER_VALIDATION_PROGRAM_ID,
    );
  }

  Future<bool> _transfer(String privateKey, String source, String destination,
      String mintAddressSend, int lameports, int decimals) async {
    // solana
    // todo
    // TxSignature txSignatureSend = await new MySolanaClient(config.net.baseUrl)
    //     .sendTransactionInstructionSend(stSend);
    // print(txSignatureSend.toString());
    try {
      TxSignature txSignatureSend =
          await new MySolanaClient(config.net.solanaBaseUrl).sendTransactionInstructionSend(stSend);
      debugPrint('Transaction: https://explorer.solana.com/tx/$txSignatureSend');
    } catch (e) {
      if (e is JsonRpcError) {
        JsonRpcError temp = e;
        debugPrint(temp.message);
        // showToast(temp.message);
      }
      return false;
    }
    return true;
  }

  List<String> parseMnemonicsInput(String inputText) {
    List<String> newList = [];
    RegExp reg = RegExp('(\\s)+');
    List<String> valList = inputText.split(reg);
    newList = DisposeArray.removeEmpty(list: valList);
    return newList;
  }

  Future<List<Map>> getTokenAccountsByOwner(String walletAddress,
      [String programId = _kTOKEN_PROGRAM_ID]) async {
    // SPL
    var result = await MySolanaClient(config.net.solanaBaseUrl)
        .getTokenAccountsByOwnerWithProgramId(walletAddress, programId)
        .catchError((e) => <Map>[]);
    return result;
  }
}

const _kTOKEN_PROGRAM_ID = 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA';
