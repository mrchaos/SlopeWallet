import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:wallet/common/config/wallet_config.dart';
import 'package:wallet/data/bean/alumni_news/alumni_news_details_bean.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wd_common_package/wd_common_package.dart';
const _SHARE_TAGS = """
""";

void initShareSdk() {
  //todo
}

///instagram
void shareInstagramCustom(
    BuildContext context, AlumniNewsDetailsBean detail, String fileUrl) async {
  if (!(await _isClientInstalled(ShareSDKPlatforms.instagram))) {
    return;
  }

  SSDKMap params = SSDKMap();
  if (Platform.isIOS) {
    params.setGeneral('', '', fileUrl, '', '', '', '', '', '', '', SSDKContentTypes.image);
  } else {
    params.setGeneral('', '', '', fileUrl, '', '', '', '', '', '', SSDKContentTypes.auto);
  }
  SharesdkPlugin.share(ShareSDKPlatforms.instagram, params,
          (SSDKResponseState state, userdata, contentEntity, SSDKError error) {
        if (SSDKResponseState.Fail == state) {
          final errorInfo = error.userInfo['description'].toString();
          if (errorInfo.isNotEmpty) showToast(errorInfo);
        }
      });
}

///line
void shareLineCustom(BuildContext context, AlumniNewsDetailsBean detail, String fileUrl) async {
  if (!(await _isClientInstalled(ShareSDKPlatforms.line))) {
    return;
  }
  SSDKMap params = SSDKMap();
  if (Platform.isIOS) {
    params.setGeneral('', '', fileUrl, '', '', '', '', '', '', '', SSDKContentTypes.image);
  } else {
    params.setGeneral('', '', '', fileUrl, '', '', '', '', '', '', SSDKContentTypes.auto);
  }
  SharesdkPlugin.share(ShareSDKPlatforms.line, params,
          (SSDKResponseState? state, userdata, contentEntity, SSDKError error) {
        if (SSDKResponseState.Fail == state) {
          final errorInfo = error.rawData?['error'].toString() ?? '';
          if (errorInfo.isNotEmpty) showToast(errorInfo);
        }
      });
}

///whatsApp
void shareWhatsAppCustom(BuildContext context, AlumniNewsDetailsBean detail, String fileUrl) async {
  if (!(await _isClientInstalled(ShareSDKPlatforms.whatsApp))) {
    return;
  }

  SSDKMap params = SSDKMap();
  if (Platform.isIOS) {
    params.setGeneral('', '', fileUrl, '', '', '', '', '', '', '', SSDKContentTypes.image);
  } else {
    params.setGeneral('', '', '', fileUrl, '', '', '', '', '', '', SSDKContentTypes.auto);
  }
  SharesdkPlugin.share(ShareSDKPlatforms.whatsApp, params,
          (SSDKResponseState state, userdata, contentEntity, SSDKError error) {
        if (SSDKResponseState.Fail == state) {
          final errorInfo = error.userInfo['description'].toString();
          if (errorInfo.isNotEmpty) showToast(errorInfo);
        }
      });
}

///Telegram
void shareTelegramCustom(BuildContext context, AlumniNewsDetailsBean detail, String fileUrl) async {
  if (!(await _isClientInstalled(ShareSDKPlatforms.telegram))) {
    return;
  }

  SSDKMap params = SSDKMap();
  if (Platform.isIOS) {
    params.setGeneral('', '', fileUrl, '', '', '', '', '', '', '', SSDKContentTypes.image);
  } else {
    params.setGeneral('', '', '', fileUrl, '', '', '', '', '', '', SSDKContentTypes.auto);
  }
  SharesdkPlugin.share(ShareSDKPlatforms.telegram, params,
          (SSDKResponseState state, userdata, contentEntity, SSDKError error) {
        print(error.userInfo.toString());

        if (SSDKResponseState.Fail == state) {
          _showShareFail(error);
        }
      });
}

///Facebook
void shareFacebookCustom(BuildContext context, AlumniNewsDetailsBean detail, String imgUrl) async {

  if (!(await _isClientInstalled(ShareSDKPlatforms.facebook))) {
    return;
  }
  SSDKMap params = SSDKMap();
  if (Platform.isIOS) {
    params = SSDKMap()
      ..setFacebook(
          "$_SHARE_TAGS",
          imgUrl,
          "",
          '',
          '',
          '',
          "",
          //  tag（）
          "",
          SSDKFacebookShareTypes.native,
          SSDKContentTypes.image);
  } else {
    params = SSDKMap()
      ..setGeneral('', '$_SHARE_TAGS', '', imgUrl, '', imgUrl, '', '', '', '',
          SSDKContentTypes.image);
    params = SSDKMap()
      ..setFacebook(
          "$_SHARE_TAGS",
          imgUrl,
          "$imgUrl",
          '',
          '',
          '',
          "",
          //  tag（）
          "",
          SSDKFacebookShareTypes.native,
          SSDKContentTypes.image);
  }
  SharesdkPlugin.share(ShareSDKPlatforms.facebook, params,
          (SSDKResponseState state, userdata, contentEntity, SSDKError error) {
        if (SSDKResponseState.Fail == state) {
          _showShareFail(error);
        }
      });
}

void _showShareFail(SSDKError error) {
  var errorInfo = '';
  if (null != error.userInfo) {
    if (error.userInfo is Map) {
      Map errInfo = error.userInfo;
      var msg = errInfo['error_message'];
      if (null != msg && 0 != msg.length) {
        errorInfo = msg;
      } else {
        var info = errInfo['user_data'];
        if (info is Map) {
          Map infoMap = info;
          var subInfo = infoMap['errors'];
          if (subInfo is List && 0 != subInfo.length) {
            var smalInfo = subInfo.first;
            if (smalInfo is Map) {
              Map smalInfoMap = smalInfo;
              var smalMsg = smalInfoMap['message']?.toString() ?? '';
              errorInfo = smalMsg;
              return;
            }
          }
        }
      }
    }
  }

  if (errorInfo.isNotEmpty) showToast(errorInfo);
}

///Twitter
void shareTwitterCustom(BuildContext context, AlumniNewsDetailsBean detail, String imgUrl) async {
  if (!(await _isClientInstalled(ShareSDKPlatforms.twitter))) {
    return;
  }
  SSDKMap params = SSDKMap();
  if (Platform.isIOS) {
    params = SSDKMap()..setTwitter("$_SHARE_TAGS", imgUrl, '', 0.0, 0.0, SSDKContentTypes.auto);
  } else {
    params = SSDKMap()
      ..setGeneral('', '$_SHARE_TAGS', '', imgUrl, '', imgUrl, '', '', '', '',
          SSDKContentTypes.image);
  }
  SharesdkPlugin.share(ShareSDKPlatforms.twitter, params,
          (SSDKResponseState state, userdata, contentEntity, SSDKError error) {
        if (SSDKResponseState.Fail == state) {
          _showShareFail(error);
        } else if (SSDKResponseState.Success == state) {
          showToast('Success');
        } else if (SSDKResponseState.Cancel == state) {
          showToast('Cancel');
        }
      });
}

Future<bool> _isClientInstalled(ShareSDKPlatform platform) async {
  dynamic result = await SharesdkPlugin.isClientInstalled(platform);
  debugPrint('_isClientInstalled result=$result');

  bool hasInstall = false;
  if (Platform.isIOS) {
    hasInstall = result;
  } else if (result is Map?) {
    Map? mapTmp = result;
    hasInstall = mapTmp?['state'] == 'installed';
  }

  if (!hasInstall) {
    showToast('App is not installed');
  }
  debugPrint('_isClientInstalled ${platform.name} = $hasInstall');

  return hasInstall;
}
