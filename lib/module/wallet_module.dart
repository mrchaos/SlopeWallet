


import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wallet/common/util/navigate_service/navigate_service.dart';
import 'package:wallet/pages/create_wallet/model/wallet_create_model.dart';
import 'package:wallet/pages/create_wallet/model/wallet_password_model.dart';
import 'package:wallet/pages/home/model/market_price_view_model.dart';
import 'package:wallet/pages/home/model/wallet_main_model.dart';
import 'package:wallet/pages/login_wallet/model/import_slope_wallet_model.dart';
import 'package:wallet/widgets/tools.dart';


class WalletModule {
  /// 
  static Future<void> init() async {
    await service.init();
    await config.init();
    config.app.appType = WalletAppType.slope;
    return Future.value();
  }

  static configGlobalContext(NavigateService rootNavService) {
    globalContext = rootNavService.key?.currentState?.overlay?.context;
  }

  static configFlavor(String flavor){
    config.net.flavor = flavor;
  }

  /// provider
  static List<SingleChildWidget> get globalProviders => [
    ChangeNotifierProvider.value(value: WalletMainModel()),
    ChangeNotifierProvider.value(value: MarketPriceViewModel.instance),
    ChangeNotifierProvider.value(value: config.app.theme),
  ];

  static VoidCallback? slopeDidLoadWallet;
  static VoidCallback? slopeDidClearWallet;
  static VoidCallback? slopeOpenDrawer;
  static VoidCallback? slopeDidLoginWallet;

  WalletModule._();
}