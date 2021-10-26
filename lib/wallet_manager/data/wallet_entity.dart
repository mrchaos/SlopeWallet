import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wallet/common/util/ai_json/ai_json.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/wallet_manager/service/wallet_manager.dart';
import 'package:wallet/wallet_manager/wallet_encrypt.dart';

class WalletEntity with WalletEntityMixin {
  String privateKey; // 
  String address; // ()
  String mnemonic; // 
  String walletId; // id()
  String walletName; // 
  String blockChain; // 
  List<CoinEntity> coins; // 
  WalletEntity({
    this.mnemonic = '',
    this.walletId = '',
    this.walletName = '',
    this.blockChain = '',
    this.privateKey = '',
    this.address = '',
    this.coins = const [],
  });

  factory WalletEntity.fromJson(Map<String, dynamic> json) {
    AiJson aiJson = AiJson(json);
    List<CoinEntity> _coins = [];
    String coinsString = aiJson.getString("coins");
    List<dynamic> coinMaps = jsonDecode(coinsString);
    coinMaps.forEach((element) {
      _coins.add(CoinEntity.fromJson(jsonDecode(element)));
    });
    return WalletEntity(
        privateKey: aiJson.getString('privateKey'),
        address: aiJson.getString('address'),
        mnemonic: aiJson.getString('mnemonic'),
        walletId: aiJson.getString('walletId'),
        walletName: aiJson.getString('walletName'),
        blockChain: aiJson.getString('blockChain'),
        coins: _coins);
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['privateKey'] = this.privateKey;
    data['address'] = this.address;
    data['mnemonic'] = this.mnemonic;
    data['walletId'] = this.walletId;
    data['walletName'] = this.walletName;
    data['blockChain'] = this.blockChain;
    List<String> jsonCoins = [];
    this.coins.forEach((element) {
      jsonCoins.add(json.encode(element.toJson()));
    });
    data['coins'] = json.encode(jsonCoins);
    return data;
  }

  /// ,
  ///
  /// md5Password => (password + md5Salt).md5
  /// walletId => (md5Password + this.address).md5
  /// aesKey =>  (md5Password + aesSalt).md5
  /// privateKey => this.privateKey.aesWithKey(aesKey)
  /// mnemonic => this.mnemonic.aesWithKey(aesKey)
  Map<String, String> encrypt({String? md5Password, String? aesKey}) {
    final Map<String, String> data = new Map<String, String>();
    String mdP = md5Password ?? walletManager.md5Password;
    String aeK = aesKey ?? walletManager.aesKey;
    final String wid = kIsWeb ? this.walletId : WalletEncrypt.generateMD5(mdP + this.address);
    final String mn = WalletEncrypt.aesEncrypt(this.mnemonic, aeK);
    final String prKey = WalletEncrypt.aesEncrypt(this.privateKey, aeK);
    List<String> jsonCoins = [];
    this.coins.forEach((element) {
      jsonCoins.add(json.encode(element.toJson()));
    });
    String coinsString = json.encode(jsonCoins);
    data['privateKey'] = prKey;
    data['address'] = this.address;
    data['mnemonic'] = mn;
    data['walletId'] = wid;
    data['walletName'] = this.walletName;
    data['blockChain'] = this.blockChain;
    data['coins'] = coinsString;
    return data;
  }

  /// 
  String decryptMnemonic() => WalletEncrypt.aesDecrypt(this.mnemonic, walletManager.aesKey);

  /// 
  String decryptPrivateKey() => WalletEncrypt.aesDecrypt(this.privateKey, walletManager.aesKey);

  /// add wallet.WalletEntityinit
  void init() {
    if (false == kIsWeb) {
      this.walletId = _generateWalletId();
    }
    this.mnemonic = _encryptMnemonic();
    this.privateKey = _encryptPrivateKey();
  }

  String _generateWalletId() => WalletEncrypt.generateMD5(walletManager.md5Password + this.address);

  /// 
  String _encryptMnemonic() => WalletEncrypt.aesEncrypt(this.mnemonic, walletManager.aesKey);

  /// 
  String _encryptPrivateKey() => WalletEncrypt.aesEncrypt(this.privateKey, walletManager.aesKey);
}

class CoinEntity with CoinEntityMixin, CoinSelectMixin {
  String contractAddress; // 
  String splAddress; // 
  String coin; // 
  int decimals; // 
  // 
  CoinEntity({
    this.contractAddress = '',
    this.splAddress = '',
    this.coin = '',
    this.decimals = 6,
    String icon = '',
    bool isSelected = false,
    bool hide = false,
    num coinSize = 0,
    num usdtPrice = 0,
  }) {
    this.icon = icon;
    this.isSelected = isSelected;
    this.hide = hide;
    this.counts = coinSize;
    this.usdtPrice = usdtPrice;
  }

  bool get isSpl => !isSOL;

  bool get isSOL => coin.toUpperCase() == 'SOL';

  factory CoinEntity.fromJson(dynamic json) {
    AiJson aiJson = AiJson(json);
    return CoinEntity(
      contractAddress: aiJson.getString('contractAddress'),
      splAddress: aiJson.getString('splAddress'),
      coin: aiJson.getString('coin'),
      icon: aiJson.getString('icon'),
      coinSize: aiJson.getNum('counts'),
      decimals: aiJson.getInt('decimals'),
      hide: aiJson.getString('hide') == '1' ? true : false,
      usdtPrice: aiJson.getNum('usdtPrice', defaultValue: 0),
    );
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['contractAddress'] = this.contractAddress;
    data['splAddress'] = this.splAddress;
    data['coin'] = this.coin;
    data['icon'] = this.icon;
    data['counts'] = this.counts.toString();
    data['decimals'] = this.decimals.toString();
    data['hide'] = this.hide ? '1' : '0';
    data['usdtPrice'] = this.usdtPrice.toString();
    return data;
  }

  CoinEntity copyWith({
    String? contractAddress,
    String? splAddress,
    String? coin,
    int? decimals,
    String? icon,
    bool? isSelected,
    bool? hide,
    num? coinSize,
    num? usdtPrice,
  }) {
    return CoinEntity(
      contractAddress: contractAddress ?? this.contractAddress,
      splAddress: splAddress ?? this.splAddress,
      coin: coin ?? this.coin,
      decimals: decimals ?? this.decimals,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
      hide: hide ?? this.hide,
      coinSize: coinSize ?? this.counts,
      usdtPrice: usdtPrice ?? this.usdtPrice,
    );
  }
}

/// 
class Coins {
  static const String maps = "MAPS";
  static const String uni = "UNI";
  static const String hxro = "HXRO";
  static const String usdt = "USDT";
  static const String link = "LINK";
  static const String sol = "SOL";
  static const String usdc = "USDC";
  static const String math = "MATH";
  static const String front = "FRONT";
  static const String akro = "AKRO";
  static const String srm = "SRM";
  static const String ray = "RAY";
  static const String oxy = "OXY";

  Coins._();
}

/// 
class BlockChains {
  static const String sol = "SOL"; // solana
  static const String btc = "BTC";
  static const String eth = "ETH";
  static const String xlm = "XLM";

  BlockChains._();
}
