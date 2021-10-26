import 'dart:ui';

import 'package:flutter/cupertino.dart';

/// 
bool isStrNullOrEmpty(String? str) {
  return str == null || str == '' || str.isEmpty;
}

extension StringExtension on String {
  Size sizeByTextStyle(TextStyle style) {
    if (isStrNullOrEmpty(this)) return Size(0, 0);
    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: this, style: style),
    );
    painter.layout();
    return painter.size;
  }

  Size sizeByFontSize(double fontSize) {
    if (isStrNullOrEmpty(this)) return Size(0, 0);
    TextPainter painter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: this, style: TextStyle(fontSize: fontSize)));
    painter.layout();
    return painter.size;
  }

  double widthByTextStyle(TextStyle style) {
    if (isStrNullOrEmpty(this)) return 0;
    TextPainter painter = TextPainter(
        textDirection: TextDirection.ltr, text: TextSpan(text: this, style: style), maxLines: 1);
    painter.layout();
    return painter.width;
  }

  double widthByFontSize(double fontSize) {
    if (isStrNullOrEmpty(this)) return 0;
    TextPainter painter = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(text: this, style: TextStyle(fontSize: fontSize)),
        maxLines: 1);
    painter.layout();
    return painter.width;
  }

  double heightByTextStyle(TextStyle style, double maxWidth) {
    if (isStrNullOrEmpty(this)) return 0;
    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: this, style: style),
    );
    painter.layout(maxWidth: maxWidth);
    return painter.height;
  }

  double heightByFontSize(double fontSize, double maxWidth) {
    if (isStrNullOrEmpty(this)) return 0;
    TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: this, style: TextStyle(fontSize: fontSize)),
    );
    painter.layout(maxWidth: maxWidth);
    return painter.height;
  }

  /// . (44，...）
  String ellAddress([int preLength = 4, int sufLength = 4]) {
    if (isStrNullOrEmpty(this)) return this;
    if ((preLength + sufLength) > this.length) return this;
    String sPre = this.substring(0, preLength);
    String sSuf = this.substring(this.length - sufLength, this.length);
    String sMid = '...';
    return sPre + sMid + sSuf;
  }

  /// "+"
  String get notBreak => replaceAll('', '\u{200B}');
}

bool isNetworkUrl(String? url) => isHttpUrl(url) || isHttpsUrl(url);

bool isHttpsUrl(String? url) {
  return (null != url) &&
      (url.length > 7) &&
      url.toString().substring(0, 8).toLowerCase() == ("https://");
}

bool isHttpUrl(String? url) {
  return (null != url) && (url.length > 6) && url.substring(0, 7).toLowerCase() == ("http://");
}

bool _strIsNetworkUrl(String url) => isNetworkUrl(url);

bool _strIsHttpUrl(String url) => isHttpUrl(url);

bool _strIsHttpsUrl(String url) => isHttpsUrl(url);

extension StringExt on String {
  bool get isNetworkUrl => _strIsNetworkUrl(this);

  bool get isHttpUrl => _strIsHttpUrl(this);

  bool get isHttpsUrl => _strIsHttpsUrl(this);

  int? parseInt({int radix = 10, int? defaultValue}) =>
      int.tryParse(this, radix: radix) ?? defaultValue;

  double? parseDouble({double? defaultValue}) =>
      (double.tryParse(this) ?? defaultValue)?.toDouble();

  num? parseNum({num? defaultValue}) => num.tryParse(this) ?? defaultValue;
}
