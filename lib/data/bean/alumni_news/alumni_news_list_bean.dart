// To parse this JSON data, do
//
//     final alumniNewsModuleBean = alumniNewsModuleBeanFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AlumniNewsListBean {
  AlumniNewsListBean({
    required this.id,
    required this.title,
    required this.author,
    required this.pnums,
    required this.itemId,
    required this.logo,
    required this.linkUrl,
    required this.createTime,
    required this.releaseStime,
  });

  final int? id;
  final String? title;
  final String? author;
  final int? pnums;
  final int? itemId;
  final String? logo;
  final String? linkUrl;
  final int? createTime;
  final int? releaseStime;

  factory AlumniNewsListBean.fromJson(String str) => AlumniNewsListBean.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AlumniNewsListBean.fromMap(Map<String, dynamic> json) => AlumniNewsListBean(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    author: json["author"] == null ? null : json["author"],
    pnums: json["pnums"] == null ? null : json["pnums"],
    itemId: json["item_id"] == null ? null : json["item_id"],
    logo: json["logo"] == null ? null : json["logo"],
    linkUrl: json["link_url"] == null ? null : json["link_url"],
    createTime: json["create_time"] == null ? null : json["create_time"],
    releaseStime: json["release_stime"] == null ? null : json["release_stime"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "author": author == null ? null : author,
    "pnums": pnums == null ? null : pnums,
    "item_id": itemId == null ? null : itemId,
    "logo": logo == null ? null : logo,
    "link_url": linkUrl == null ? null : linkUrl,
    "create_time": createTime == null ? null : createTime,
    "create_time": releaseStime == null ? null : releaseStime,
  };
}
