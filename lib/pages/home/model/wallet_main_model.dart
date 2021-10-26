import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/router_service/router_table.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/data/apis/token_list_api.dart';
import 'package:wallet/generated/assets.dart';
import 'package:wallet/module/wallet_module.dart';
import 'package:wallet/pages/browser/browser_model.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/home/create_coin_page/widget/create_coin_model.dart';
import 'package:wallet/pages/home/model/market_price_view_model.dart';
import 'package:wallet/utils/solana_tokens.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wallet/wallet_manager/database/wallet_database.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wd_common_package/wd_common_package.dart';

import 'wallet_ext.dart';

export 'wallet_ext.dart';

class WalletMainModel extends ViewModel {
  factory WalletMainModel() => _getInstance();

  static WalletMainModel get instance => _getInstance();
  static WalletMainModel? _instance;

  WalletMainModel._internal();

  static WalletMainModel _getInstance() {
    if (null == _instance) {
      _instance = WalletMainModel._internal();
    }
    return _instance!;
  }

  bool _isFirstAppear = true;

  /// 
  List<WalletEntity> allWallets = [];

  List<WalletEntity> getWalletsByBlockChain(String blockChain) {
    var result = allWallets
        .where((element) => element.blockChain == blockChain)
        .toList()
        .cast<WalletEntity>();
    return result;
  }

  /// 
  Future queryAllWallets() async {
    var res = await walletDatabase.queryAllWallet();
    allWallets.clear();
    res.forEach((element) {
      allWallets.add(element..initUI(element));
    });
    if (allWallets.length > 0) {
      currentWallet = allWallets.first;
    } else {
      currentWallet = null;
    }
    _isFirstAppear = false;

    notifyListeners();

    ///
    getAllWalletTokenList();
    return allWallets;
  }

  Future addWallet(WalletEntity entity) async {
    var res = await walletDatabase.insertWallet(walletEntity: entity);
    if (kIsWeb && (res is String)) {
      entity.walletId = res;
    }
    allWallets.add(entity
      ..init()
      ..initUI(entity));
    notifyListeners();

    getAllWalletTokenList();

    return Future.value();
  }

  Future deleteWallet(WalletEntity entity) async {
    await walletDatabase.deleteWallet(walletEntity: entity);
    allWallets.removeWhere((element) => element.walletName == entity.walletName);
    if (allWallets.length > 0 && null != currentWallet) {
      if (entity.walletName == currentWallet!.walletName) {
        currentWallet = allWallets.first;
      }
    } else {
      /// 
      currentWallet = null;
      walletManager.cleanPassword();
      resetPasswordWrongTimes();
      if (config.app.appType == WalletAppType.slope) {
        service.router.pop();
        service.router.pop();
        WalletModule.slopeDidClearWallet!();
      } else {
        BrowserModel.instance.clearSearchHistory();
        BrowserModel.instance.clearRecentlyList();
        BrowserModel.instance.clearFavoriteList();
        CreateCoinModel().clearCacheCustomCoin();
        service.router.pushNamedAndRemoveUntil(RouteName.createWalletPage, (route) => false);
      }
    }
    notifyListeners();
    return Future.value();
  }

  Future slopeDisConnectWallet() async {
    service.cache.setInt(inputWrongTimesKey, 0);
    service.cache.setString(lastWrongDateKey, '');

    await walletDatabase.deleteAllWallet();
    allWallets.clear();

    /// 
    currentWallet = null;
    walletManager.cleanPassword();
    WalletModule.slopeDidClearWallet!();
    return Future.value();
  }

  Future<void> updateWallet(WalletEntity? entity) async {
    if (null == entity) return;
    //
    var tokens = entity.coins.toList(growable: false);
    final map = <String, CoinEntity>{};
    tokens.forEach((token) => map[token.splAddress] = token);

    entity.coins = map.values.toList();
    //。 SOL
    entity.coins.sort((c1, c2) {
      if (c1.isSOL) {
        return -1;
      } else if (c2.isSOL) {
        return 2;
      } else {
        // 
        return c1.coin.compareTo(c2.coin);
      }
    });
    await walletDatabase.updateWallet(walletEntity: entity);
    notifyListeners();
  }

  /// 
  List<String> supportedBlockChains = [
    BlockChains.sol,
  ];

  /// 
  List<String> get blockChainsNormalIcon {
    return List<String>.generate(supportedBlockChains.length,
        (index) => blockChainNormalIconMap[supportedBlockChains[index]]!);
  }

  /// 
  List<String> get blockChainsSelectedIcon {
    return List<String>.generate(supportedBlockChains.length,
        (index) => blockChainSelectedIconMap[supportedBlockChains[index]]!);
  }

  /// 
  WalletEntity? _currentWallet;

  WalletEntity? get currentWallet => _currentWallet;

  ///
  set currentWallet(WalletEntity? value) {
    if (_currentWallet?.address == value?.address) return;
    _currentWallet = value;
    if (!_isFirstAppear) {
      _refreshCurrentWalletBalance();
    }
    getAllWalletTokenList();
  }

  void _refreshCurrentWalletBalance() => getCurrentWalletUsdtBalance();

  ///
  Future<Decimal> getCurrentWalletUsdtBalance() async {
    if (null != currentWallet) {
      await getAWalletUsdtBalance(currentWallet!);
    }
    return currentWallet?.totalUsdtBalance ?? Decimal.zero;
  }

  /// 
  Future<Decimal> getAWalletUsdtBalance(WalletEntity wallet) async {
    //
    var showCoins = wallet.coins.where((coin) => coin.hide != true).toList();
    for (var spl in showCoins) {
      try {
        if (spl.isSOL) {
          await walletManager
              .getBalance(wallet.address, errorDefaultValue: spl.counts)
              .then((value) => spl.counts = value);
        } else {
          await walletManager
              .getTokenBalance(spl.splAddress, errorDefaultValue: spl.counts)
              .then((value) => spl.counts = value);
        }
      } catch (e) {
        // print(e);
      }
      notifyListeners();
    }

    return wallet.totalUsdtBalance;
  }

  // （, SOL）
  Future<double> getAddressBalanceFuture(CoinEntity coinEntity) async {
    double balance = coinEntity.counts.toDouble();
    if (coinEntity.isSOL && null != currentWallet) {
      //SOL
      balance = await WalletManager.instance
          .getBalance(currentWallet!.address, errorDefaultValue: coinEntity.counts);
    } else {
      //
      balance = await WalletManager.instance
          .getTokenBalance(coinEntity.splAddress, errorDefaultValue: coinEntity.counts);
    }
    return balance;
  }

  // SOL
  Future<bool> transferAccounts(
      {required String fromAddress,
      required String toAddress,
      required String privateKey,
      required int lamports}) {
    debugPrint('Send $lamports lamports from $fromAddress to $toAddress');
    return walletManager
        .sendTransaction(
            sourceAddress: fromAddress,
            destinationAddress: toAddress,
            privateKey: privateKey,
            lamports: lamports)
        .then((value) {
      return (value != null);
    }).catchError((e) => Future.value(false));
  }

  ///SPL 
  Future<bool> transfer(
      {String privateKey = '',
      String walletAddress = '',
      String source = '',
      String mintAddressSend = '',
      required int lameports,
      int decimals = 6}) {
    debugPrint('Send $lameports lamports to $walletAddress');
    return walletManager
        .transfer(
          privateKey: privateKey,
          walletAddress: walletAddress,
          source: source,
          mintAddressSend: mintAddressSend,
          lameports: lameports,
          decimals: decimals,
        )
        .catchError((e) => Future.value(false));
  }

  ///
  Future<void> getAllWalletTokenList() async {
    for (var wallet in allWallets) {
      getWalletTokenList(wallet);
    }
    _updateCoinPrice();
  }

  void _updateCoinPrice() async {
    MarketPriceViewModel.instance.getMarketPairPrice([
      ...?currentWallet?.coins.map((e) => e.coin),
    ]).whenComplete(() => this.notifyListeners());
  }

  /// 
  Future<void> getCurrentWalletTokenList() async {
    if (currentWallet != null) {
      await getWalletTokenList(currentWallet!);
    }
    _updateCoinPrice();
  }

  /// 
  /// * [wallet] 
  Future<void> getWalletTokenList(WalletEntity wallet) async {
    //test 
    // currentWallet?.address = '35QnTr7Z1QJf41Kw6EQ9HLC76J6YGiwc46FjXAL95E3N';

    var walletAddress = wallet.address;
    if (walletAddress.isEmpty) {
      return;
    }
    // 
    var result = await walletManager.getTokenAccountsByOwner(walletAddress).catchError((e, s) {
      //report error
      Sentry.captureException(e, stackTrace: s);
      return <Map>[];
    });
    // logger.d('WalletMainModel.getWalletTokenList ${result.length}');
    List<CoinEntity> contractList = await getContractList().catchError((e) => <CoinEntity>[]);
    for (var elem in result) {
      var info = elem['account']['data']['parsed']['info'];
      var mint = info['mint'];
      var splAddress = elem['pubkey'];
      // 
      var splCoin = contractList.firstWhereOrNull((coin) => coin.contractAddress == mint);
      // 
      var cacheCoin = wallet.coins.firstWhereOrNull((coin) => coin.contractAddress == mint);
      var amount = info['tokenAmount']['uiAmount'];
      if (null != amount && amount is num && amount == amount.toInt()) {
        amount = amount.toInt();
      }

      cacheCoin?.splAddress = splAddress ?? cacheCoin.splAddress;
      cacheCoin?.counts = amount ?? cacheCoin.counts;

      final decimals = info['tokenAmount']['decimals'];

      if (null != splCoin) {
        //copy coin
        splCoin = splCoin.copyWith(hide: cacheCoin?.hide ?? false);
        splCoin.splAddress = splAddress;
        splCoin.decimals = decimals;

        if (amount is num) {
          splCoin.counts = amount;
        }

        if (splCoin.icon.trim().isEmpty) {
          //。solana tokens
          final splToken = SOLANA_TOKENS.firstWhereOrNull((e) => e['address'] == mint);
          var rawIcon = splToken?['logoURI']?.toString() ?? '';
          splCoin.icon = rawIcon;
        }

        cacheCoin?.icon = splCoin.icon;

        if (null != cacheCoin && cacheCoin.coin.trim().isEmpty) {
          //。solana tokens
          final splToken = SOLANA_TOKENS.firstWhereOrNull((e) => e['address'] == mint);
          var symbol = splToken?['symbol']?.toString() ?? '';
          cacheCoin.coin = symbol;
        }
      } else {
        //app 
        final splToken = SOLANA_TOKENS.firstWhereOrNull((e) => e['address'] == mint);
        var rawIcon = splToken?['logoURI']?.toString() ?? '';

        // 。 ，Unknown
        var tokenName = cacheCoin?.coin ?? "";
        if (tokenName.isEmpty) {
          tokenName = splToken?['symbol']?.toString() ?? 'Unknown';
        }
        splCoin = CoinEntity(
          coin: tokenName,
          splAddress: splAddress,
          contractAddress: mint,
          icon: rawIcon,
          decimals: decimals,
          coinSize: amount ?? 0,
        );
      }

      if (cacheCoin == null) {
        // 
        wallet.coins.add(splCoin);
      }
    }

    for (var c in wallet.coins) {
      if (c.coin == 'Unknown' && c.icon.isEmpty) {
        c.hide = true;
      }
    }

    var solCoin = wallet.coins.firstWhereOrNull((element) => element.isSOL);
    solCoin?.coin = "SOL";
    solCoin?.icon = Assets.assets_image_contract_address_sol_png;
    solCoin?.splAddress = walletAddress;
    solCoin?.contractAddress = WRAPPED_SOL_MINT;
    solCoin?.decimals = 9;
    solCoin?.hide = false;
    solCoin?.isSelected = true;
    notifyListeners();
    //
    updateWallet(wallet);
    getCurrentWalletUsdtBalance();
  }

  List<CoinEntity> _contractList = [];

  // 
  Future<List<CoinEntity>> getContractList() async {
    if (_contractList.length > 0) return _contractList;
    logger.d('_contractList:$_contractList');
    final result = await TokenListApi().request();
    if (result.data?['msg'] == 'success') {
      _contractList = result.tokenList;
    } else {
      _contractList = <CoinEntity>[];
    }
    _setContractCache();
    return _contractList;
  }

  void _setContractCache() async {
    if (_contractList.isNotEmpty) {
      service.cache.setStrings(
          _kContractListKey, _contractList.map((e) => json.encode(e.toJson())).toList());
    }
  }

  List<CoinEntity> loadContractCache() {
    final strings = service.cache.getStrings(_kContractListKey, defaultValue: []) ?? [];
    final list = strings.map((e) => CoinEntity.fromJson(json.decode(e))).toList();
    return list;
  }
}

const _kContractListKey = '_kContractListKey';
mixin CoinEntityMixin {
  String icon = ''; // icon
  num counts = 0; // 
  /// 1USDT
  num usdtPrice = 0.0;

  ///USDT ( 100 USDT)
  Decimal get usdtBalance => Decimal.parse(usdtPrice.toString()) * Decimal.parse(counts.toString());

  ///。(：1 SOL)
  Decimal get balance => Decimal.parse(counts.toString());
}

mixin CoinSelectMixin {
  bool isSelected = false; // 
  ///。 ，。。
  bool hide = false;
}

mixin WalletEntityMixin {
  String walletCardBg = '';
  String chainMenuNorIcon = '';
  String chainMenuSelIcon = '';
  Color walletBgColor = Colors.transparent;

  void initUI(WalletEntity entity) {
    // entity.coins.forEach((element) {
    //   String coinName = element.coin.toUpperCase();
    //   // element.icon = coinIconMap[coinName] ?? '';
    // });
    if (entity.blockChain == BlockChains.sol) {
      walletCardBg = Assets.assets_svg_menu_bg_sol_svg;
      walletBgColor = Color(0xFF67EBBA);
    }
    chainMenuNorIcon = blockChainNormalIconMap[entity.blockChain] ?? '';
    chainMenuSelIcon = blockChainSelectedIconMap[entity.blockChain] ?? '';
  }
}

Map<String, String> blockChainNormalIconMap = {
  BlockChains.sol: Assets.assets_svg_menu_salana_normal_svg,
  BlockChains.btc: Assets.assets_svg_menu_btc_normal_svg,
  BlockChains.xlm: Assets.assets_svg_menu_xlm_normal_svg,
  BlockChains.eth: Assets.assets_svg_menu_eth_normal_svg,
};

Map<String, String> blockChainSelectedIconMap = {
  BlockChains.sol: Assets.assets_svg_menu_salana_selected_svg,
  BlockChains.btc: Assets.assets_svg_menu_btc_selected_svg,
  BlockChains.xlm: Assets.assets_svg_menu_xlm_selected_svg,
  BlockChains.eth: Assets.assets_svg_menu_eth_selected_svg,
};
