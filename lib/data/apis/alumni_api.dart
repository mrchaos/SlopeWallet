import 'dart:convert';

import 'package:wallet/common/network/single_protocol.dart';
import 'package:wallet/pages/alumni/rank/models/rank_index_chart_model.dart';
import 'package:wallet/pages/alumni/rank/models/rank_index_top_model.dart';

class RankChart extends SingleProtocol<RankChart> {
  late RankChartModel _rankInfo;

  @override
  String get baseUrl => 'https://api.staked.xyz';

  @override
  String get api => '/apiSolana/getSolanaProjectTvl';

  RankChartModel get rankInfo => _rankInfo;

  ///
  WDRequestType get method => WDRequestType.get;

  @override
  Map<String, dynamic>? get arguments => {};

  @override
  void onParse(data) {
    final mapData = jsonDecode(data);
    if (mapData['success'] ?? false) {
      _rankInfo = RankChartModel.fromJson(mapData);
    } else {
      _rankInfo = RankChartModel.fromJson({});
    }
  }
}

class TopTen extends SingleProtocol<TopTen> {
  late RankTopModel _topData;
  final int page;
  final String sort;
  final String order;

  TopTen({this.page = 1, this.sort = 'tvl', this.order = 'desc'});

  @override
  String get baseUrl => 'https://api.staked.xyz';

  @override
  String get api => '/apiSolana/getSolanaProjectTokensRank';

  RankTopModel get topData => _topData;

  ///
  WDRequestType get method => WDRequestType.get;

  @override
  Map<String, dynamic>? get arguments => {
        'page': page,
        'sort': sort.toLowerCase(),
        'order': order.toLowerCase(),
        'limit': 20
      };

  @override
  void onParse(data) {
    final mapData = jsonDecode(data);
    if (mapData['success'] ?? false) {
      _topData = RankTopModel.fromJson(mapData);
    } else {
      _topData = RankTopModel.fromJson({});
    }
  }
}
