import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:slope_solana_client/src/bean/transaction.dart';
import 'package:wallet/pages/coin_detail/record_type.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wd_common_package/wd_common_package.dart';

import 'tx_instruction_ext.dart';

extension ConfirmedTransactionExt on MyConfirmedTransaction {
  Iterable<MyTxInstruction> get instructions {
    var instructions = <MyTxInstruction>[...?transaction.message.instructions];
    return instructions;
  }

  Iterable<MyTxInstruction> get innerInstructions {
    final innerIns = meta!.innerInstructions.map((e) => e.value).fold<List<MyTxInstruction>>(
        [],
        (previousValue, element) => [
              ...previousValue,
              ...element,
            ]);
    return innerIns;
  }
}

const _kPageSize = 10;

class _TransactionCache {
  List<MyConfirmedTransactionWithTXID> _transactionList = [];
  List<MyConfirmedTransactionWithTXID> _showList = [];
}

///
final _kTransactionCacheMap = <String, _TransactionCache>{};

class CoinDetailModel extends ViewModel {
  final WalletEntity walletCoin;
  final CoinEntity coinEntity;
  bool _hasMoreTransaction = false;
  List<MyConfirmedTransactionWithTXID> _transactionList = [];
  List<MyConfirmedTransactionWithTXID> _showList = [];
  RecordType _recordType = RecordType.All;

  CoinDetailModel(this.walletCoin, this.coinEntity) {
    //
    // walletCoin.address='SOL';
    // coinEntity.splAddress='';
    _restoreData();
  }

  ///
  _restoreData() {
    var cache = _kTransactionCacheMap['${walletCoin.address}-${coinEntity.splAddress}'];
    if (null != cache) {
      _transactionList = cache._transactionList;
      _showList = cache._showList;
    }
  }

  ///()
  _storeData() {
    final cacheKey = '${walletCoin.address}-${coinEntity.splAddress}';
    var cache = _kTransactionCacheMap[cacheKey];
    cache ??= _TransactionCache();
    cache._transactionList = _transactionList;
    cache._showList = _showList;
    _kTransactionCacheMap[cacheKey] = cache;
  }

  RecordType get recordType => _recordType;

  set recordType(RecordType value) {
    _recordType = value;
    notifyListeners();
  }

  ///
  List<MyConfirmedTransactionWithTXID> get showTransactionList {
    if (recordType == RecordType.All) return _showList;
    return _showList.where((t) {
      var where = t.instructions.where((ins) {
        if (recordType == RecordType.Receive) {
          return ins.getTxType(splAddress) == TxType.Receive;
        }
        return ins.getTxType(splAddress) == TxType.Send;
      });
      return where.isNotEmpty;
    }).toList();
  }

  Future<void> getBalance() async {
    if (coinEntity.isSOL) {
      //SOL
      coinEntity.counts = await WalletManager.instance
          .getBalance(walletCoin.address, errorDefaultValue: coinEntity.counts);
    } else {
      //
      coinEntity.counts = await WalletManager.instance
          .getTokenBalance(coinEntity.splAddress, errorDefaultValue: coinEntity.counts);
    }
  }

  bool get hasMoreTransaction => _hasMoreTransaction;

  ///
  Future<bool> refreshTransactions() => _getTransactionsList(true);

  ///
  Future<bool> loadMoreTransactions() => _getTransactionsList(false);

  String get splAddress {
    String address;
    if (coinEntity.isSOL) {
      //SOL Address
      address = walletCoin.address;
    } else {
      //
      address = coinEntity.splAddress;
    }
    return address;
  }

  ///
  Future<bool> _getTransactionsList([bool isRefresh = false]) async {
    List<MyConfirmedTransactionWithTXID> _backupTransactionList = [];
    //find transaction from solana
    return true;
  }
}
