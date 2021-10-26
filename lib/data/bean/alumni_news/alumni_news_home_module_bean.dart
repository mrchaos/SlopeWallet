// To parse this JSON data, do
//
//     final alumniNewsModuleBean = alumniNewsModuleBeanFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import './alumni_news_list_bean.dart';


class AlumniNewsModuleBean {
  AlumniNewsModuleBean({
    required this.id,
    required this.name,
    required this.childs,
  });

  final int id;
  final String name;
  final List<AlumniNewsListBean> childs;

  factory AlumniNewsModuleBean.fromJson(String str) => AlumniNewsModuleBean.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AlumniNewsModuleBean.fromMap(Map<String, dynamic> json) => AlumniNewsModuleBean(
    id: json["id"],
    name: json["name"],
    childs: List<AlumniNewsListBean>.from(json["childs"].map((x) => AlumniNewsListBean.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "childs": List<dynamic>.from(childs.map((x) => x.toMap())),
  };
}

// class AlumniNewsListBean {
//   AlumniNewsListBean({
//     required this.id,
//     required this.title,
//     required this.author,
//     required this.pnums,
//     required this.itemId,
//     required this.logo,
//     required this.linkUrl,
//     required this.createTime,
//   });
//
//   final int id;
//   final String title;
//   final String author;
//   final int pnums;
//   final int itemId;
//   final String logo;
//   final String linkUrl;
//   final int createTime;
//
//   factory AlumniNewsListBean.fromJson(String str) => AlumniNewsListBean.fromMap(json.decode(str));
//
//   String toJson() => json.encode(toMap());
//
//   factory AlumniNewsListBean.fromMap(Map<String, dynamic> json) => AlumniNewsListBean(
//     id: json["id"],
//     title: json["title"],
//     author: json["author"],
//     pnums: json["pnums"],
//     itemId: json["item_id"],
//     logo: json["logo"],
//     linkUrl: json["link_url"],
//     createTime: json["create_time"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "title": title,
//     "author": author,
//     "pnums": pnums,
//     "item_id": itemId,
//     "logo": logo,
//     "link_url": linkUrl,
//     "create_time": createTime,
//   };
// }
