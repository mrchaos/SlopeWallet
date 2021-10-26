import 'dart:io';

import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/common/network/single_protocol.dart';
import 'package:wallet/common/util/ai_json/ai_json.dart';
import 'package:wallet/pages/alumni/activity/model/ama_model.dart';
import 'package:wd_common_package/wd_common_package.dart';

class AmaListApi extends SingleProtocol<AmaListApi> {
    List<Ama> _amaData=[];
    final int page;
    final int pageSize;

    AmaListApi({this.page = 1, this.pageSize = 10});

  @override
  String get baseUrl =>config.net.phpBaseUrl;

  @override
  String get api => '/api/v1/ama/list';

  List<Ama> get amaList => _amaData;

  ///
  WDRequestType get method => WDRequestType.get;

    String _currentPage = "1";
    int _lastPage = 1;
    String get currentPage => _currentPage;
    int get lastPage => _lastPage;
  @override
  Map<String, dynamic>? get arguments => {
    "page": page,
    "pageSize": pageSize
  };

  @override
  void onParse(resp) {
    if (resp['code'] == HttpStatus.ok) {
      AiJson aiJson = AiJson(resp);
      List data =aiJson.getArray('data');

      _currentPage = aiJson.data['data']['current_page'];
      _lastPage = aiJson.data['data']['last_page'];
      _amaData = aiJson.data['data']['data'].map<Ama>((e) {
        final amaData =  Ama.fromJson(e);
        return amaData;
      }).toList();
    }
  }
}
