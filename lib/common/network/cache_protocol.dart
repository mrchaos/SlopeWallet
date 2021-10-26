import 'dart:async';
import 'dart:convert';

import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/network/base/base_protocol.dart';
import 'package:dio/dio.dart';
import 'package:wallet/common/network/base/i_stream.dart';
import 'package:wallet/db/dex_database.dart';
import 'package:wd_common_package/wd_common_package.dart';
import 'base/base_http.dart';
import 'single_protocol.dart' show WDRequestType;
import 'package:sentry/sentry.dart';

/// ,
///
/// [T]
abstract class CacheProtocol<T extends BaseProtocol> extends BaseProtocol
    with IStream<T> {
  @override
  Stream<T> request() async* {


    try {
      String? data =
          await DexDatabase.instance.queryCache('$baseUrl$api', params: jsonEncode(arguments));
      if (data != null && data.isNotEmpty) {
        this.parse(jsonDecode(data));
        yield (this as T);
      }
    } on Exception catch (e) {
      // Sentry.captureException(e, stackTrace: e);
    } finally {
      logger.d('header:$header');
      BaseHttp.instance.configBaseUrl(baseUrl);
      // BaseHttp.instance.configHeader(header);
      var res = await BaseHttp.instance.open(
        api,
        method: method,
        arguments: arguments,
        formData: formData,
        cancelToken: cancelToken,
        headers: header,
      );

      if (jsonEncode(data) != jsonEncode(res)) {
        try {
          DexDatabase.instance
              .insert({'url': '$baseUrl$api', 'params': jsonEncode(arguments), 'data': jsonEncode(res)});
        } on Exception catch (e) {
          // TODO
        } finally {
          this.parse(res);
          yield (this as T);
        }
      } else {
        /// ，
        // this.parse(res);
        // yield (this as T);
      }
    }


  }

  @override
  void parse(dynamic data) {
    /// ,
    this.data = data;
    super.parse(data);
  }

  Future? cancel() {
    cancelToken?.cancel();
    return null;
  }

  ///
  WDRequestType get method => WDRequestType.post;

  ///
  FormData? get formData => null;

  /// api
  String get api;

  ///
  Map<String, dynamic>? get arguments => null;

  ///
  CancelToken? get cancelToken => null;

  /// baseUrl
  String get baseUrl => config.net.httpBaseUrl;

  /// header
  Map<String, dynamic> get header => {};
}
