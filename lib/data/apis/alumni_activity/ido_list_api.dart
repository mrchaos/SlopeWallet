import 'dart:io';

import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/network/single_protocol.dart';
import 'package:wallet/common/util/ai_json/ai_json.dart';
import 'package:wallet/pages/alumni/activity/model/ido_model.dart';
import 'package:wd_common_package/wd_common_package.dart';

class IdoLsitApi extends SingleProtocol<IdoLsitApi> {
    List<Ido> _idoData=[];

  @override
  String get baseUrl =>config.net.phpBaseUrl;

  @override
  String get api => '/api/v1/ido/lists';

  List<Ido> get idoList => _idoData;

  /// 
  WDRequestType get method => WDRequestType.get;

  @override
  Map<String, dynamic>? get arguments => {};

  @override
  void onParse(resp) {
    if (resp['code'] == HttpStatus.ok) {
      AiJson aiJson = AiJson(resp);
      List data =aiJson.getArray('data');

      _idoData = aiJson.data['data']['data'].map<Ido>((e) {
        final idoData =  Ido.fromJson(e);
        return idoData;
      }).toList();
    }
  }
}
