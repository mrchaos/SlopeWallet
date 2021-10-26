import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void showLoading({
  String? msg,
  Widget? indicator,
  EasyLoadingMaskType? maskType,
  bool? dismissOnTap = false,
}) {
  EasyLoading.show(
      status: msg,
      indicator: indicator,
      maskType: maskType,
      dismissOnTap: dismissOnTap
  );
}

void showToast(
    String? msg,
    {
      Duration? duration = const Duration(seconds: 2),
      bool? dismissOnTap = true,
    }) {
  if (null == msg) return;
  EasyLoading.showToast(msg, duration: duration, dismissOnTap: dismissOnTap);
}

void showSuccess(
    String? msg,
    {
      Duration? duration = const Duration(seconds: 2),
      bool? dismissOnTap = true,
    }) {
  if (null == msg) return;
  EasyLoading.showSuccess(msg, duration: duration, dismissOnTap: dismissOnTap);
}
void showError(
    String? msg,
    {
      Duration? duration = const Duration(seconds: 2),
      bool? dismissOnTap = true,
    }) {
  if (null == msg) return;
  EasyLoading.showError(msg, duration: duration, dismissOnTap: dismissOnTap);
}

void showInfo(
    String? msg,
    {
      Duration? duration = const Duration(seconds: 2),
      bool? dismissOnTap = true,
    }) {
  if (null == msg) return;
  EasyLoading.showInfo(msg, duration: duration, dismissOnTap: dismissOnTap);
}


void dismissLoading() {
  EasyLoading.dismiss();
}

void hideLoading() {
  EasyLoading.dismiss();
}




