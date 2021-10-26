// To parse this JSON data, do
//
//     final alumniNewsDetailsBean = alumniNewsDetailsBeanFromMap(jsonString);

import 'dart:convert';

class AlumniNewsDetailsBean {
  AlumniNewsDetailsBean(
      { this.id,
       this.title,
       this.content,
       this.author,
       this.pnums,
       this.itemId,
       this.logo,
       this.linkUrl,
       this.createTime,
       this.releaseStime,
       this.shareUrl});

  final int? id;
  final String? title;
  final String? content;
  final String? author;
  final int? pnums;
  final int? itemId;
  final String? logo;
  final String? linkUrl;
  final int? createTime;
  final String? shareUrl;
  final int? releaseStime;

  factory AlumniNewsDetailsBean.fromJson(String str) =>
      AlumniNewsDetailsBean.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AlumniNewsDetailsBean.fromMap(Map<String, dynamic> json) => AlumniNewsDetailsBean(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null:json["content"],
        author: json["author"]== null ? null :json["author"],
        pnums: json["pnums"] == null ? null :json["pnums"],
        itemId: json["item_id"] == null ? null :json["item_id"],
        logo: json["logo"] == null ? null : json["logo"] ,
        linkUrl: json["link_url"] == null?null:json["link_url"],
        createTime:json["create_time"] == null?null:json["create_time"],
        shareUrl: json["share_url"]== null?null:json["share_url"],
        releaseStime: json["release_stime"] == null? null :json["release_stime"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "content": content,
        "author": author,
        "pnums": pnums,
        "item_id": itemId,
        "logo": logo,
        "link_url": linkUrl,
        "create_time": createTime,
        "share_url": shareUrl,
        "release_stime": releaseStime,
      };
}

