
import 'package:dio/dio.dart';
import 'package:wallet/common/network/base/base_http.dart';
import 'package:wd_common_package/wd_common_package.dart';

import 'base_http.dart';

abstract class BaseProtocol {
  int? code;
  String? msg;
  dynamic data;

  bool get isSuccess => (null != data) && (this.data is! WDError);

  // late AiJson aJson;

  void parse(dynamic data) {
    if (isSuccess) {
      onParse(data);
    } else {
      if (this.data is WDError) {
        WDError e = this.data as WDError;
        parseError(e);
        if (e.hasErrResponse) {
          onParseErrorFromResponse(e.errResponse!);
        }
      } else {
        parseError(WDError());
      }
    }
  }

  void onParse(dynamic respData);

  void onParseErrorFromResponse(Response errResponse) {
    /// errResponse.data
    ///
    /// 
    // this.code = errResponse.statusCode;
    // this.msg = '${this.code}: ${errResponse.data}';
  }

  void parseError(WDError error) {
    this.code = error.errorCode;
    this.msg = error.errorMsg;
  }
}
