class AmaModel {
  num? total;
  String? perPage;
  num? currentPage;
  num? lastPage;
  late List<Ama> data;

  AmaModel(
      {this.total, this.perPage, this.currentPage, this.lastPage, required this.data});

  AmaModel.fromJson(dynamic json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Ama.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['total'] = total;
    map['per_page'] = perPage;
    map['current_page'] = currentPage;
    map['last_page'] = lastPage;
    map['data'] = data.map((v) => v.toJson()).toList();
    return map;
  }
}

class Ama {
  late num id;
  late String name;
  late String logo;
  late String info;
  late String linkUrl;
  late num createTime;

  Ama(
      {required this.id,
      required this.name,
      required this.logo,
      required this.info,
      required this.linkUrl,
      required this.createTime});

  Ama.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    info = json['info'];
    linkUrl = json['link_url'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['logo'] = logo;
    map['info'] = info;
    map['link_url'] = linkUrl;
    map['create_time'] = createTime;
    return map;
  }
}
