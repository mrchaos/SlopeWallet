import 'package:flutter/services.dart';
import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/service/i_service.dart';
import 'package:wd_common_package/wd_common_package.dart';


class ImageService extends IService with ImageLoadable {

  @override
  Future<void>? init() async {
  }

  @override
  String? get packageName => config.app.appType == WalletAppType.slope ? config.app.packageName : null;
}

