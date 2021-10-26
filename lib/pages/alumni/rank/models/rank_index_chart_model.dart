class RankChartModel {
  Data data;
  String message;
  bool success;

  RankChartModel(
      {required this.data, required this.message, required this.success});

  factory RankChartModel.fromJson(Map<String, dynamic> json) {
    return RankChartModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : Data(),
      message: json['message'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  List<SonalaTotalItem>? list;
  String? tps;
  String? totalTVL;
  String? txn;
  double? tvlPercentChange;

  Data({this.list, this.tps, this.totalTVL, this.txn, this.tvlPercentChange});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        list: json['list'] != null
            ? (json['list'] as List)
                .map((i) => SonalaTotalItem.fromJson(i))
                .toList()
            : null,
        tps: json['tps'],
        totalTVL: json['totalTVL'],
        txn: json['txn'],
        tvlPercentChange: json['tvlPercentChange']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txn'] = this.txn;
    data['totalTVL'] = this.totalTVL;
    data['tps'] = this.tps;
    data['tvlPercentChange'] = this.tvlPercentChange;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SonalaTotalItem {
  String showDate;
  String tvl;

  SonalaTotalItem({required this.showDate, required this.tvl});

  factory SonalaTotalItem.fromJson(Map<String, dynamic> json) {
    return SonalaTotalItem(
      showDate: json['showDate'],
      tvl: json['tvl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showDate'] = this.showDate;
    data['tvl'] = this.tvl;
    return data;
  }
}
