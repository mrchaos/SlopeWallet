class IdoModel {
  int? total;
  String? perPage;
  int? currentPage;
  int? lastPage;
  List<Ido>? data;

  IdoModel(
      {this.total, this.perPage, this.currentPage, this.lastPage, this.data});

  IdoModel.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Ido.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['total'] = total;
    map['per_page'] = perPage;
    map['current_page'] = currentPage;
    map['last_page'] = lastPage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Ido {
  int? id;
  String? logo;
  String? name;
  String? linkUrl;
  int? releaseSTime;
  int? releaseETime;
  num? airdropNums;
  String? tokenNums;
  int? status;
  int? createTime;
  int? updateTime;
  String? timeTip;

  Ido(
      {this.id,
      this.logo,
      this.name,
      this.linkUrl,
      this.releaseSTime,
      this.releaseETime,
      this.airdropNums,
      this.tokenNums,
      this.status,
      this.createTime,
      this.updateTime,
      this.timeTip});

  Ido.fromJson(dynamic json) {
    id = json['id'];
    logo = json['logo'];
    name = json['name'];
    linkUrl = json['link_url'];
    releaseSTime = json['release_stime'];
    releaseETime = json['release_etime'];
    airdropNums = json['airdrop_nums'];
    tokenNums = json['token_nums'];
    status = json['status'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    timeTip = json['time_tip'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['logo'] = logo;
    map['name'] = name;
    map['link_url'] = linkUrl;
    map['release_stime'] = releaseSTime;
    map['release_etime'] = releaseETime;
    map['airdrop_nums'] = airdropNums;
    map['token_nums'] = tokenNums;
    map['status'] = status;
    map['create_time'] = createTime;
    map['update_time'] = updateTime;
    map['time_tip'] = timeTip;
    return map;
  }
}
