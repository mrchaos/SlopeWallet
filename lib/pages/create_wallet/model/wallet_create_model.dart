import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/string/string_util.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/wallet_manager/database/wallet_database.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wd_common_package/wd_common_package.dart';

class WalletCreateModel extends ViewModel {
  factory WalletCreateModel() => _getInstance();

  static WalletCreateModel get instance => _getInstance();
  static WalletCreateModel? _instance;

  WalletCreateModel._internal();

  static WalletCreateModel _getInstance() {
    if (null == _instance) {
      _instance = WalletCreateModel._internal();
    }
    return _instance!;
  }

  // ///
  // String chain = BlockChains.sol;
  // bool needBackSlopeTradePage = false;
  ///
  WalletEntity? walletEntity;

  ///
  bool isCreating = false;

  ///
  bool get isFirstWallet {
    return WalletMainModel.instance.allWallets.length <= 0;
  }

  /// ,drawerwalletListPage
  // bool isFromDrawer = false;

  ///
  Future<bool> createWallet(WalletCreateRelatedData pageData) async {
    isCreating = true;
    showLoading();

    /// loading
    if (kIsWeb) await Future.delayed(Duration(milliseconds: 200));
    WalletEntity entity = await walletManager.createWallet();
    bool createSuccess = false;
    dismissLoading();
    // ,
    if (walletManager.validateMnemonic(entity.mnemonic)) {
      walletEntity = entity;
      pageData.wallet = entity;
      service.router.pushNamed(
        RouteName.mnemonicRecommendPage,
        arguments: pageData.copyWith(
            isSetupPassword: true,
            backPopPageCount: pageData.backPopPageCount + 5),
      );
      isCreating = false;
      createSuccess = true;
    } else {
      showToast('Invalid mnemonic words');
      walletEntity = null;
      isCreating = false;
      createSuccess = false;
    }
    return Future.value(createSuccess);
  }

  ///
  Future<bool> saveWallet(
      BuildContext context, WalletCreateRelatedData pageData) async {
    bool _saveSuccess = false;
    String walletName = "SOLANA Wallet1";
    if (null != pageData.wallet) {
      if (false == isFirstWallet) {
        walletName = _generateWalletName(context);
      }
      pageData.wallet!.walletName = walletName;
      if (false == isFirstWallet) {
        context.read<WalletMainModel>().addWallet(pageData.wallet!);
      } else {
        await walletManager.saveWallet(walletEntity: pageData.wallet!);
      }
      _saveSuccess = true;
    }
    return _saveSuccess;
  }

  String _generateWalletName(BuildContext context) {
    late String walletName;
    var ws = context.read<WalletMainModel>().allWallets;
    int nameIdx = ws.length + 1;
    walletName = "Wallet$nameIdx";
    ws.forEach((element) {
      if (walletName == element.walletName) {
        nameIdx += 1;
        walletName = "Wallet$nameIdx";
      }
    });
    return walletName;
  }

  ///
  ///
  /// [mnemonic]
  void initMnemonic(String mnemonic) {
    mnemonicMap.clear();
    List<String> mnemonics = mnemonic.split(" ");
    for (int i = 0; i < mnemonics.length; i++) {
      mnemonicMap.addAll({"${i + 1}": mnemonics[i]});
      _emptySelectedWords.addAll({"${i + 1}": ""});
    }
  }

  ///
  Map<String, String> mnemonicMap = {};

  final Map<String, String> _emptySelectedWords = {};

  ///
  Map<String, String> selectedMnemonics = {};

  List<RandomMnemonicBean> randomMnemonics = [];
  List<RandomMnemonicBean> selectedMnemonics1 = [];

  ///
  void resetSelectedMnemonics(int resetIndex) {
    String value = selectedMnemonics.values.toList()[resetIndex];
    List<RandomMnemonicBean> beans = randomMnemonics
        .where((element) => element.word == value)
        .toList()
        .cast<RandomMnemonicBean>();
    if (beans.length > 0) {
      RandomMnemonicBean? bean =
          beans.firstWhereOrNull((element) => element.isSelected == true);
      bean?.isSelected = false;
    }

    selectedMnemonics[(resetIndex + 1).toString()] = "";

    List<String> selectedStrList = [];
    for (String w in selectedMnemonics.values.toList()) {
      if (!isStrNullOrEmpty(w)) selectedStrList.add(w);
    }

    for (int i = 0; i < selectedMnemonics.values.length; i++) {
      selectedMnemonics["${(i + 1)}"] = "";
    }

    for (int i = 0; i < selectedStrList.length; i++) {
      selectedMnemonics["${(i + 1)}"] = selectedStrList[i];
    }
  }

  ///
  Future generateRandomWords() async {
//create Mnemonics
  }

  ///
  String querySelectingIndex() {
    for (int i = 0; i < selectedMnemonics.length; i++) {
      if (isStrNullOrEmpty(selectedMnemonics.values.toList()[i])) {
        return selectedMnemonics.keys.toList()[i];
      }
    }
    return "";
  }

  /// ,,true, false
  bool selectWord(RandomMnemonicBean wordsBean) {
    String indexKey = querySelectingIndex();
    selectedMnemonics[indexKey] = wordsBean.word;
    wordsBean.isSelected = true;

    for (int i = 0; i < randomMnemonics.length; i++) {
      if (false == randomMnemonics[i].isSelected) return false;
    }
    return true;
  }

  bool isVerificationSuccess() {
    for (int i = 0; i < randomMnemonics.length; i++) {
      if (selectedMnemonics[(i + 1).toString()] !=
          mnemonicMap[(i + 1).toString()]) return false;
      // if (false == randomMnemonics[i].isSelected) return false;
    }
    return true;
  }
}

class RandomMnemonicBean {
  String word = "";
  bool isSelected = false;
  int id = -1;

  RandomMnemonicBean({this.word = "", this.isSelected = false, this.id = -1});
}
