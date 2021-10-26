import 'package:wallet/common/config/app_config/app_config.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wd_common_package/wd_common_package.dart';

import '../i_service.dart';

class SvgService extends IService with SvgLoadable {
  @override
  String? get packageName =>
      config.app.appType == WalletAppType.slope ? config.app.packageName : null;

  @override
  Future<void>? init() {}
}
