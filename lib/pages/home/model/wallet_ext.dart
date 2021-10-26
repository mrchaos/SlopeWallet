import 'package:decimal/decimal.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';

import 'market_price_view_model.dart';

extension WalletExt on WalletEntity? {
  /// USDT
  Decimal get totalUsdtBalance {
    if (null == this) return Decimal.zero;
    var total = this!.coins.map((spl) {
      final price =
          MarketPriceViewModel.instance.getMarketPrice(spl.coin, defaultValue: spl.usdtPrice);
      spl.usdtPrice = price;
      final splUsdt = spl.usdtBalance;
      return splUsdt;
    }).fold<Decimal>(Decimal.zero, (previousValue, element) => previousValue + element);

    return total;
  }
}
