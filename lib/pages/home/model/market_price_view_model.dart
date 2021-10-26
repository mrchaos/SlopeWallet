import 'dart:async';

import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/data/apis/marekt_price_api.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wd_common_package/wd_common_package.dart';

final Map<String, num> _marketPriceMap = {};

class MarketPriceViewModel extends ViewModel {
  Timer? _priceTimer;

  MarketPriceViewModel._();

  static MarketPriceViewModel? _instance;

  static MarketPriceViewModel get instance {
    if (null == _instance) {
      _instance = MarketPriceViewModel._();
    }
    return _instance!;
  }

  @override
  void dispose() {
    _priceTimer?.cancel();
    super.dispose();
  }

  ////USDT
  num getMarketPrice(String symbol, {num defaultValue = 0}) {
    if (symbol.toUpperCase() == 'USDC' || symbol.toUpperCase() == 'USDT') {
      return 1;
    }
    var price = _marketPriceMap[symbol.toUpperCase()] ?? defaultValue;
    return price;
  }

  ///
  Future<Map<String, num>> getMarketPairPrice(Iterable<String> symbols) async {
    if (symbols.isEmpty) return {};
    final api = await MarketPairApi(
      ['sol', ...symbols].toSet().toList(growable: false),
    ).request();
    _marketPriceMap.addAll(api.marketUsdPriceMap);
    notifyListeners();
    return _marketPriceMap;
  }
}
