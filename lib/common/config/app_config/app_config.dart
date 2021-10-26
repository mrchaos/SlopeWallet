import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:wallet/common/config/i_config.dart';
import 'package:wallet/theme/app_theme.dart';
import 'package:logger/logger.dart';
import 'package:wd_common_package/wd_common_package.dart';

enum WalletAppType {
  independence,   // ()
  slope,          // slope dex
}


/// app
class AppConfig extends IConfig {

  /// app
  final AppTheme theme = AppTheme();

  /// 
  late Locale appLocale;
  /// 
  String packageName = "wallet";

  /// 
  WalletAppType appType = WalletAppType.independence;

  @override
  Future<void>? init() async {
    _initLogger();
    await theme.init();
    return null;
  }

  void _initLogger() {
    if(kReleaseMode){
      logger.level = Level.info;
    }else {
      logger.level = Level.debug;
    }
  }

}

