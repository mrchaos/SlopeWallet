import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:wallet/common/config/i_config.dart';

class DeviceConfig extends IConfig {
  String _devId = '';

  String get deviceId => _devId;

  @override
  Future<void>? init() async {
    if (kIsWeb) return;
    _devId = await _getDevId();
  }

  ///。 id
  Future<String> _getDevId() async {
    final devInfo = DeviceInfoPlugin();
    String id = '';
    if (!kIsWeb && Platform.isAndroid) {
      id = (await devInfo.androidInfo).androidId;
    } else if (!kIsWeb && Platform.isIOS) {
      id = (await devInfo.iosInfo).identifierForVendor;
    }
    return id;
  }
}
