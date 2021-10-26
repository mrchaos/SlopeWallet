import 'package:dio/dio.dart';
import 'package:wd_common_package/wd_common_package.dart';

class BaseHttpMethod {
  static const String get = "GET";
  static const String post = "POST";
  static const String put = "PUT";

  const BaseHttpMethod._();
}

abstract class DioProtocol {
  late final Dio dio;

  Future<dynamic> get(
    String path, {
    String method = BaseHttpMethod.get,
    Map<String, dynamic>? arguments,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    Options options = Options(
      method: method,
      headers: headers,
    );
    Response res = await dio.get(
      path,
      options: options,
      queryParameters: arguments,
      cancelToken: cancelToken,
    );
    return res.data;
  }

  Future<dynamic> post(
    String path, {
    String method = BaseHttpMethod.post,
    Map<String, dynamic>? arguments,
    FormData? formData,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    Options options = Options(
      method: method,
      headers: headers,
    );
    Response res;
    if (arguments != null) {
      res = await dio.post(
        path,
        options: options,
        data: arguments,
        cancelToken: cancelToken,
      );
    } else {
      res = await dio.post(
        path,
        options: options,
        data: formData,
        cancelToken: cancelToken,
      );
    }
    return res.data;
  }

  Future<Response> uploadFile(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String method = BaseHttpMethod.put,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    options ??= Options(method: method);
    Response res = await dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return res;
  }
}
