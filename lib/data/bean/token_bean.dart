// To parse this JSON data, do
//
//     final tokenListBean = tokenListBeanFromMap(jsonString);

import 'dart:convert';

class TokenListBean {
  TokenListBean({
    required this.baseCurrency,
    required this.iconUrl,
    required this.baseMintAddress,
    required this.decimals,
  });

  final String baseCurrency;
  final String iconUrl;
  final String baseMintAddress;
  final int decimals;

  factory TokenListBean.fromJson(String str) =>
      TokenListBean.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TokenListBean.fromMap(Map<String, dynamic> json) => TokenListBean(
        baseCurrency: json["baseCurrency"],
        iconUrl: json["iconUrl"],
        baseMintAddress: json["baseMintAddress"],
        decimals: json["decimals"],
      );

  Map<String, dynamic> toMap() => {
        "baseCurrency": baseCurrency,
        "iconUrl": iconUrl,
        "baseMintAddress": baseMintAddress,
        "decimals": decimals,
      };
}
