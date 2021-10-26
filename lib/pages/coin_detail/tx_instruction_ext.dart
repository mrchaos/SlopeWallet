import 'package:decimal/decimal.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:slope_solana_client/src/bean/transaction.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/widgets/currency_format.dart';

import 'coin_detail_model.dart' show ConfirmedTransactionExt;

enum TxType {
  Send,
  Receive,
  Success,
}

extension MyConfirmedTransactionWithTXIDExt on MyConfirmedTransactionWithTXID {
  bool get isTxSuccess {
    final isNotEmpty = instructions.where((ins) {
      //
      return ins is! MyTransferTx && ins is! MyTransferTxSpl;
    }).isNotEmpty;
    return isNotEmpty;
  }
}

extension MyTxInstructionExt on MyTxInstruction? {
  TxType getTxType(String splAddress) {
    var txType = TxType.Success;

    if (this is MyTransferTx) {
      if ((this as MyTransferTx).source == splAddress) {
        txType = TxType.Send;
      } else {
        txType = TxType.Receive;
      }
    } else if (this is MyTransferTxSpl) {
      if ((this as MyTransferTxSpl).source == splAddress) {
        txType = TxType.Send;
      } else {
        txType = TxType.Receive;
      }
    }

    return txType;
  }

  String get uiAmount {
    num size = 0;
    if (this is MyTransferTx) {
      size = (this as MyTransferTx).coinSize;
    } else if (this is MyTransferTxSpl) {
      size = (this as MyTransferTxSpl).tokenAmount.uiAmount ?? 0;
    }

    final str = CurrencyFormat.formatDecimal(Decimal.parse(size.toString()));
    return str;
  }

  String get source {
    if (this is MyTransferTx) {
      return (this as MyTransferTx).source;
    } else if (this is MyTransferTxSpl) {
      return (this as MyTransferTxSpl).source;
    }
    return '';
  }

  String get destination {
    if (this is MyTransferTx) {
      return (this as MyTransferTx).destination;
    } else if (this is MyTransferTxSpl) {
      return (this as MyTransferTxSpl).destination;
    }
    return '';
  }
}

extension MyConfirmedTransactionWithTXIDListExt on List<MyConfirmedTransactionWithTXID> {
  Iterable<MyConfirmedTransactionWithTXID> whereToken(CoinEntity token) {
    return where((tx) {
      //
      if (tx.meta?.err != null) return false;
      if (token.isSOL) {
        //SOLSOL
        var solTx = tx.instructions.whereType<MyTransferTx>().isNotEmpty;
        if (!solTx) {
          if (tx.instructions.where((ins) => ins is! MyUnknownTx).isEmpty) {
            solTx = tx.innerInstructions.whereType<MyTransferTx>().isNotEmpty;
          }
        }

        return solTx;
      } else {
        var splTx = tx.instructions.whereType<MyTransferTxSpl>().isNotEmpty;
        splTx = splTx || tx.instructions.whereType<MyTransferTxSplNew>().isNotEmpty;

        if (!splTx) {
          if (tx.instructions.where((ins) => ins is! MyUnknownTx).isEmpty) {
            splTx = splTx || tx.innerInstructions.whereType<MyTransferTxSpl>().isNotEmpty;
            splTx = splTx || tx.innerInstructions.whereType<MyTransferTxSplNew>().isNotEmpty;
          }
        }
        return splTx;
      }
    });
  }
}
