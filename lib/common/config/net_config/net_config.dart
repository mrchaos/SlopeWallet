import 'package:flutter/cupertino.dart';
import 'package:slope_solana_client/slope_solana_client.dart';
import 'package:wallet/common/config/i_config.dart';
import 'package:wallet/common/service/wallet_service.dart';
import 'package:wd_common_package/wd_common_package.dart';

class FlavorSymbol {
  static const String app = "app";
  static const String appDev = "appDev";
  static const String appTest = "appTest";

  const FlavorSymbol._();
}

const Map<String, String> flavorMap = {
  FlavorSymbol.app: "",
  FlavorSymbol.appDev: "",
  FlavorSymbol.appTest: "",
};

/// 。
const String _defaultFlavor = FlavorSymbol.app;

/// 
const String kBuildDefaultFlavor = String.fromEnvironment("flavor", defaultValue: _defaultFlavor);

/// 
final bool kIsPublicVersion = FlavorSymbol.app == kBuildDefaultFlavor;

/// 
final bool kIsTestVersion = FlavorSymbol.appDev == kBuildDefaultFlavor;
const _DefaultRpcNet = SolanaNet.SlopeNet;

/// 
class NetConfig extends IConfig {
  /// rpc
  String get solanaBaseUrl {
    /// ,
    // if (isSlopeDex) return _DefaultRpcNet.apiUrl;
    return solanaNet.apiUrl;
  }

  /// http
  String get httpBaseUrl => _javaHostMap[flavor] ?? _javaHostMap[_defaultFlavor]!;

  String get phpBaseUrl => _phpHostMap[flavor] ?? _phpHostMap[_defaultFlavor]!;

  String get fileBaseUrl => _fileHostMap[flavor] ?? _fileHostMap[_defaultFlavor]!;

  static const String _kFlavorSymbolKey = "_kWalletFlavorSymbolKey";
  static const String _kSolanaNetKey = "_kSolanaNetKey";

  SolanaNet? _solanaNet;

  SolanaNet get solanaNet {
    if (null == _solanaNet) {
      ///load solana net from cache
      final apiUrl = service.cache.getString(_kSolanaNetKey, defaultValue: _DefaultRpcNet.apiUrl);
      for (var net in SolanaNet.values) {
        if (net.apiUrl == apiUrl) {
          _solanaNet = net;
          break;
        }
      }
      _solanaNet ??= _DefaultRpcNet;
    }
    return _solanaNet!;
  }

  ///Solana
  set solanaNet(SolanaNet value) {
    if (value == _solanaNet) return;
    _solanaNet = value;
    service.cache.setString(_kSolanaNetKey, value.apiUrl);
    logger.d("solana switch to ${value.netName}: ${value.apiUrl}");
    solanaNetNotifier.value = solanaNet;
  }

  /// ：
  /// * [app] :
  /// * [appDev] :
  String? _flavor;

  /// 
  String get flavor {
    if (null == _flavor) {
      _flavor = service.cache.getString(_kFlavorSymbolKey, defaultValue: kBuildDefaultFlavor);
    }
    return _flavor!;
  }

  /// 
  /// value: app/appDev/appDev
  set flavor(String value) {
    assert(
        value == FlavorSymbol.app || value == FlavorSymbol.appDev || value == FlavorSymbol.appTest);
    _flavor = value;
    service.cache.setString(_kFlavorSymbolKey, value);
    logger.d("flavor switch to $value${flavorMap[value]}");
  }

  /// java 
  final Map<String, String> _javaHostMap = {
    FlavorSymbol.app: "api host ",
    FlavorSymbol.appDev: "api host ",
    FlavorSymbol.appTest: "api host ",
  };

  /// php 
  final Map<String, String> _phpHostMap = {
    FlavorSymbol.app: "api host ",
    FlavorSymbol.appDev: "api host ",
    FlavorSymbol.appTest: "api host ",
  };

  /// 
  final Map<String, String> _fileHostMap = {
    FlavorSymbol.app: "api host ",
    FlavorSymbol.appDev: "api host ",
    FlavorSymbol.appTest: "api host ",
  };

  final solanaNetNotifier = ValueNotifier<SolanaNet>(_DefaultRpcNet);

  @override
  Future<void>? init() async {
    //do something
    solanaNetNotifier.value = solanaNet;
  }
}
