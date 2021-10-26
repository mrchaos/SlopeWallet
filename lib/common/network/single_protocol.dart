
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/network/base/base_protocol.dart';
import 'package:wallet/common/network/base/i_request.dart';
import 'package:dio/dio.dart';
import 'package:wd_common_package/wd_common_package.dart';
import 'base/base_http.dart';

enum WDRequestType { get, post, formData }

/// ,
///
/// [T]
abstract class SingleProtocol<T extends BaseProtocol> extends BaseProtocol
    with IRequest<T> {
  @override
  Future<T> request() async {
    BaseHttp.instance.configBaseUrl(baseUrl);
    logger.d('header:$header');
    // BaseHttp.instance.configHeader(header);
    var res = await BaseHttp.instance.open(
      api,
      method: method,
      arguments: arguments,
      formData: formData,
      cancelToken: cancelToken,
      headers: header,
    );
    this.parse(res);
    return this as T;
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
