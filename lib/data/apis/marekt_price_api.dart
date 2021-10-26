import 'dart:io';
import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' hide Key;
import 'package:tuple/tuple.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/network/single_protocol.dart';
import 'package:wallet/common/util/ai_json/ai_json.dart';


class MarketPairApi extends SingleProtocol<MarketPairApi> {
  Map<String, num> _marketPrice = const {};
  final List<String> _symbolList;


  MarketPairApi(
    this._symbolList, {
  });

  @override
  String get baseUrl => config.net.phpBaseUrl;

  @override
  String get api => '/api/v1/coins/price';

  @override
  Map<String, dynamic>? get arguments {

    final map = {
      'symbols': _symbolList.map((e) => e.toLowerCase()).toSet().join(','),
    };

    return map;
  }

  @override
  WDRequestType get method => WDRequestType.post;

  Map<String, num> get marketUsdPriceMap => _marketPrice;

  @override
  void onParse(resp) {
    AiJson aiJson = AiJson(resp);
    final data = aiJson.getArray('data');
    _marketPrice = Map.fromEntries(data.map((e) => MapEntry(
          e['symbol']?.toString().toUpperCase() ?? '',
          e['usd'] ?? 0,
        )));
  }
}

