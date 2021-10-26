import 'package:wallet/common/config/device_config/device_config.dart';
import 'package:wallet/common/config/i_config.dart';
import 'package:wallet/common/config/package_config/package_config.dart';
import 'package:wallet/common/network/base/base_http.dart';

import 'app_config/app_config.dart';
import 'net_config/net_config.dart';

final WalletConfig config = WalletConfig();

bool get isSlopeDex => config.app.appType == WalletAppType.slope;

bool get isSlopeWallet => config.app.appType == WalletAppType.independence;

class WalletConfig extends IConfig {
  factory WalletConfig() => _getInstance();

  static WalletConfig get instance => _getInstance();
  static WalletConfig? _instance;

  WalletConfig._internal();

  static WalletConfig _getInstance() {
    if (null == _instance) {
      _instance = WalletConfig._internal();
    }
    return _instance!;
  }

  @override
  Future<void>? init() async {
    await app.init();
    await net.init();
    await package.init();
    await device.init();
    await BaseHttp.instance.init();
  }

  final app = AppConfig();
  final net = NetConfig();
  final package = PackageConfig();
  final device = DeviceConfig();
}
