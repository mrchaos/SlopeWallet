

import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ScreenUtil {

  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;

  static double statusBarHeight(BuildContext context){
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double topPadding = window.padding.top / pixelRatio;
    return topPadding;
  }
  static double bottomPaddingHeight(BuildContext context){
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double topPadding = window.padding.bottom / pixelRatio;
    return topPadding;
  }

}