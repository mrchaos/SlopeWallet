class RankTopModel {
  Data data;
  String? message;
  bool? success;

  RankTopModel({required this.data, this.message, this.success});

  factory RankTopModel.fromJson(Map<String, dynamic> json) {
    return RankTopModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : Data(list: []),
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
  List<X> list;
  String? total;

  Data({required this.list, this.total});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      list: json['list'] != null
          ? (json['list'] as List).map((i) => X.fromJson(i)).toList()
          : [],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['list'] = this.list.map((v) => v.toJson()).toList();
    return data;
  }
}

class X {
  String ID;
  String img;
  String like;
  String percentChange;
  String price;
  List<String> tags;
  String title;
  String token;
  String tvl;
  String tvlShort;

  X(
      {required this.ID,
      required this.img,
      required this.like,
      required this.percentChange,
      required this.price,
      required this.tags,
      required this.title,
      required this.token,
      required this.tvl,
      required this.tvlShort});

  factory X.fromJson(Map<String, dynamic> json) {
    final fuck = json['tvlShort'];
    json['price'] =
        json['price'] is num ? json['price'].toString() : json['price'];
    json['tvl'] = json['tvl'] is num ? json['tvl'].toString() : json['tvl'];
    json['tvlShort'] = fuck is num ? fuck.toString() : fuck;

    return X(
      ID: json['ID'],
      img:
          'https://medishares-cn.oss-cn-hangzhou.aliyuncs.com/solana_project/${json['img']}',
      like: json['like'],
      percentChange: json['percentChange'],
      price: double.parse(json['price']) <= 0 ? '--' : json['price'],
      tags: json['tags'] != null ? new List<String>.from(json['tags']) : [],
      title: json['title'],
      token: json['token'],
      tvl: json['tvl'],
      tvlShort: json['tvlShort'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iD'] = this.ID;
    data['img'] = this.img;
    data['like'] = this.like;
    data['percentChange'] = this.percentChange;
    data['price'] = this.price;
    data['title'] = this.title;
    data['token'] = this.token;
    data['tvl'] = this.tvl;
    data['tvlShort'] = this.tvlShort;
    if (this.tags != null) {
      data['tags'] = this.tags;
    }
    return data;
  }
}
