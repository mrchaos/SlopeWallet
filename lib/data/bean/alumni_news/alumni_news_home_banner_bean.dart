// To parse this JSON data, do
//
//     final AlumniNewsBannerBean = AlumniNewsBannerBeanFromMap(jsonString);

import 'dart:convert';

class AlumniNewsBannerBean {
  AlumniNewsBannerBean({
    this.id,
    this.banner,
    this.releaseStime,
    this.releaseEtime,
    this.status,
    this.weight,
    this.pnums,
    this.jumpType,
    this.jumpUrl,
    this.info,
    this.langId,
    this.itemId,
    this.createTime,
    this.updateTime,
    this.newTitle
  });

  final int? id;
  final String? banner;
  final int? releaseStime;
  final int? releaseEtime;
  final int? status;
  final int? weight;
  final int? pnums;
  final int? jumpType;
  final String? jumpUrl;
  final String? info;
  final String? newTitle;
  final int? langId;
  final int? itemId;
  final int? createTime;
  final int? updateTime;

  factory AlumniNewsBannerBean.fromJson(String str) => AlumniNewsBannerBean.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AlumniNewsBannerBean.fromMap(Map<String, dynamic> json) => AlumniNewsBannerBean(
    id: json["id"] == null ? null : json["id"],
    banner: json["banner"] == null ? null : json["banner"],
    releaseStime: json["release_stime"] == null ? null : json["release_stime"],
    releaseEtime: json["release_etime"] == null ? null : json["release_etime"],
    status: json["status"] == null ? null : json["status"],
    weight: json["weight"] == null ? null : json["weight"],
    pnums: json["pnums"] == null ? null : json["pnums"],
    jumpType: json["jump_type"] == null ? null : json["jump_type"],
    jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
    info: json["info"] == null ? null : json["info"],
    langId: json["lang_id"] == null ? null : json["lang_id"],
    itemId: json["item_id"] == null ? null : json["item_id"],
    newTitle: json["new_title"] == null ? null : json["new_title"],
    createTime: json["create_time"] == null ? null : json["create_time"],
    updateTime: json["update_time"] == null ? null : json["update_time"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "banner": banner == null ? null : banner,
    "release_stime": releaseStime == null ? null : releaseStime,
    "release_etime": releaseEtime == null ? null : releaseEtime,
    "status": status == null ? null : status,
    "weight": weight == null ? null : weight,
    "pnums": pnums == null ? null : pnums,
    "jump_type": jumpType == null ? null : jumpType,
    "jump_url": jumpUrl == null ? null : jumpUrl,
    "info": info == null ? null : info,
    "lang_id": langId == null ? null : langId,
    "item_id": itemId == null ? null : itemId,
    "create_time": createTime == null ? null : createTime,
    "new_title": newTitle == null ? null : newTitle,
    "update_time": updateTime == null ? null : updateTime,
  };
}
