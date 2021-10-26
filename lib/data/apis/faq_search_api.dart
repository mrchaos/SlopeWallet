import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/network/base/base_http.dart';
import 'package:wallet/common/network/single_protocol.dart';
import 'package:wallet/common/util/ai_json/ai_json.dart';
import 'package:wallet/data/apis/faq_detail_api.dart';

class FaqSearchApi extends SingleProtocol<FaqSearchApi> with FaqSignParamsProtocol {
  final String keyword;

  FaqSearchApi({
    required this.keyword,
  });

  @override
  String get baseUrl => config.net.phpBaseUrl;

  @override
  String get api => "/api/v1/article/search_articles";

  @override
  Map<String, dynamic>? get arguments => {"keyword": keyword};

  @override
  Map<String, dynamic> get header => {"sign": signParams(arguments)};

  @override
  WDRequestType get method => WDRequestType.get;

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
