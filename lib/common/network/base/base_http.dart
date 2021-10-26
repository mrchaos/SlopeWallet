import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:wallet/common/config/net_config/net_config.dart';
import 'package:wallet/common/network/single_protocol.dart';

import 'dio_protocol.dart';

///
// class ErrorCode {
//   static int netError = 600; //
//   static int dataParseError = 14; //
//   static int success = 80000000; //
//   static int kickError = 1012101; //
//   static int serverRepairing = 500; //
// }

///
const int unknownErrorCode = -100000;
const String unknownErrorMsg = "request failed";

/// Dio
Map<DioErrorType, int> dioErrorCode = {
  DioErrorType.connectTimeout: -5,
  DioErrorType.receiveTimeout: -6,
  DioErrorType.sendTimeout: -7,
  DioErrorType.cancel: -8,
};

Map<DioErrorType, String> dioErrorMsg = {
  DioErrorType.other: "connection failed",
  DioErrorType.connectTimeout: "connection timeout",
  DioErrorType.receiveTimeout: "receive a timeout",
  DioErrorType.sendTimeout: "send timeout",
  DioErrorType.cancel: "the request to cancel",
  DioErrorType.response: "server response, but with a incorrect status,",
};

const int _kReceiveTimeout = 10000;
const int _kConnectTimeout = 30000;
const int _kSendTimeout = 10000;

class WDError {
  bool hasErrResponse;
  Response? errResponse;
  int errorCode;
  String errorMsg;

  WDError(
      {this.hasErrResponse = false,
      this.errResponse,
      this.errorCode = unknownErrorCode,
      this.errorMsg = unknownErrorMsg});
}

class BaseHttp with DioProtocol {
  factory BaseHttp() => _getInstance();
  static BaseHttp? _instance;

  static BaseHttp get instance => _getInstance();

  static BaseHttp _getInstance() {
    if (null == _instance) {
      _instance = BaseHttp._internal();
    }
    return _instance!;
  }

  Future init() async {
    if (dio.httpClientAdapter is DefaultHttpClientAdapter) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        /// https
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }

    ///
    // await _configProxy();
    return null;
  }

  BaseHttp._internal() {
    dio = Dio(
      BaseOptions(
        connectTimeout: _kConnectTimeout,
        receiveTimeout: _kReceiveTimeout,
        sendTimeout: _kSendTimeout,
        responseType: ResponseType.json,
        headers: baseHeader,
      ),
    );

    if (!kIsPublicVersion) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
        ),
      );
    }
  }

  static Map<String, dynamic> baseHeader = {
    "content-type": "application/json;charset=UTF-8",
    "accept": "*/*",
    // "source": TargetPlatform.iOS == defaultTargetPlatform ? "ios" : "android",
  };

  Future<dynamic> open(String path,
      {WDRequestType method = WDRequestType.get,
      Map<String, dynamic>? arguments,
      CancelToken? cancelToken,
      FormData? formData,
      Map<String, dynamic>? headers}) async {
    dynamic result;
    try {
      if (method == WDRequestType.get) {
        result = await get(path, arguments: arguments, cancelToken: cancelToken, headers: headers);
      } else if (method == WDRequestType.post) {
        result = await post(path,
            arguments: arguments, formData: formData, cancelToken: cancelToken, headers: headers);
      }
    } catch (e) {
      WDError error = WDError(errorCode: unknownErrorCode, errorMsg: unknownErrorMsg);
      if (e is DioError) {
        if (e.type == DioErrorType.response) {
          /// code, e.response.data
          if (null != e.response?.data) {
            error.hasErrResponse = true;
            error.errResponse = e.response!;
          }
          if (null != e.response?.statusCode) {
            error.errorCode = e.response!.statusCode!;
          }
          if (null != e.response?.statusMessage) {
            error.errorMsg = e.response!.statusMessage!;
          } else {
            error.errorMsg = dioErrorMsg[e.type]!;
          }
        } else if (e.type == DioErrorType.other) {
          if (null != e.error) {
            error.errorMsg = e.error.toString();
          }
        } else {
          error.errorCode = dioErrorCode[e.type]!;
          error.errorMsg = dioErrorMsg[e.type]!;
        }
      }
      result = error;
    }
    return result;
  }

  void parseErrorFromResponse(Response response) {}

  void configBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    var cacheManager = DioCacheManager(CacheConfig(
        baseUrl: baseUrl,
        defaultMaxStale: Duration(days: 30),
        defaultMaxAge: Duration(days: 0),
        databaseName: 'http_cache'));
    dio.interceptors.add(cacheManager.interceptor);
  }

  void configHeader(Map<String, dynamic> header) {
    if (header.length <= 0) return;
    dio.options.headers.addAll(header);
  }

// Future _configProxy() async {
// if (!kReleaseMode) {
//   var proxyMap = await PolePlugin.getSystemProxy();
//   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//       (client) {
//     //
//     String? host;
//     String? port;
//     if (null != proxyMap && proxyMap is Map && proxyMap.length == 2) {
//       host = proxyMap["proxyHost"].toString();
//       port = proxyMap["proxyPort"].toString();
//     }
//     String? proxy;
//     if (!isStrNullOrEmpty(host) && !isStrNullOrEmpty(port)) {
//       proxy = "PROXY $host:$port";
//     }
//     client.findProxy = (uri) {
//       return proxy ?? "DIRECT";
//     };
//   };
// }
// return null;
// }
}
