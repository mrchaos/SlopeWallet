import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wallet/common/config/i_config.dart';
import 'package:wd_common_package/wd_common_package.dart';

const String webVersion = String.fromEnvironment("webVersion", defaultValue: "");
class PackageConfig extends IConfig {
  String appName = "";
  String packageName = "";
  String version = "";
  String buildNumber = "";

  @override
  Future<void>? init() async {
    if (kIsWeb) {
      version = webVersion;
    } else {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      this.appName = packageInfo.appName;
      this.packageName = packageInfo.packageName;
      this.version = packageInfo.version;
      this.buildNumber = packageInfo.buildNumber;
    }
    logger.d("appName: $appName "
        "\npackageName: $packageName"
        "\nversion: $version"
        "\nbuildNumber: $buildNumber");
  }
}
