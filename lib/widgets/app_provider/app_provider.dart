
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/pages/browser/browser_model.dart';
import 'package:wallet/pages/home/model/market_price_view_model.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/pages/swap/swap_convert_provider.dart';

import '../../main_model.dart';

/// provider
class AppProvider {
  static Widget wrapGlobalProviders(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: config.app.theme),
        ChangeNotifierProvider.value(value: WalletMainModel()),
        ChangeNotifierProvider.value(value: MarketPriceViewModel.instance),
        ChangeNotifierProvider.value(value: BrowserModel()),
        ChangeNotifierProvider.value(value: MainModel()),
      ],
      child: child,
    );
  }
}
