import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/network/base/base_http.dart';
import 'package:wallet/common/network/single_protocol.dart';
import 'package:wallet/common/util/ai_json/ai_json.dart';

class FaqDetailApi extends SingleProtocol<FaqDetailApi> with FaqSignParamsProtocol {
  String id;

  FaqDetailApi({
    required this.id,
  });

  @override
  String get baseUrl => config.net.phpBaseUrl;

  @override
  String get api => "/api/v1/article/get_detail";

  @override
  Map<String, dynamic>? get arguments => {"id": id};

  @override
  WDRequestType get method => WDRequestType.get;

  @override
  Map<String, dynamic> get header => {"sign": signParams(arguments)};

  @override
  void onParse(data) {
    if (data is WDError && data.hasErrResponse && null != data.errResponse) {
      onParseErrorFromResponse(data.errResponse!);
      return;
    }

    if (data is Map) {
      final aiJson = AiJson(data);
    }
  }
}

abstract class FaqSignParamsProtocol {
  /// faq
  String signParams(dynamic params) {
    // sign params
    //todo
    // debugPrint('signParams sign: $md5String');
    return md5String;
  }
}
