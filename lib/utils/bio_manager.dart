import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:wallet/generated/l10n.dart';
import 'package:wallet/utils/global.dart';
import 'package:wallet/widgets/loading/loading_util.dart';
import 'package:wallet/generated/assets.dart';

bool _wasShowAuthGuide = false;

void _cancelAuthentication() {
  _wasShowAuthGuide = false;
  _auth.stopAuthentication();
}

Future<bool> showGuideThenCheck(BuildContext context, {String timesLimitString = ''}) async {
  // 1
  // DateTime dateNow = DateTime.now();
  // if (null != G.dtCheckSystemError) {
  //   int difMins = dateNow.difference(G.dtCheckSystemError!).inMinutes;
  //   if (1 <= difMins) G.wasCheckSystemError = false;
  // }

  bool maxThanIphonex = false;

  if (Platform.isIOS) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    maxThanIphonex = G.deviceMaxThanIPhoneX(iosInfo.utsname.machine);
  }

  // ：iphonex，
  // if (!(Platform.isIOS && maxThanIphonex)) {
  //   _wasShowAuthGuide = true;
  //
  //   ///
  //   showModalBottomSheet(
  //       context: context,
  //       // isScrollControlled: true,
  //       builder: (_) => WillPopScope(
  //             onWillPop: () => Future.value(false),
  //             child: Material(
  //               child: Container(
  //                 color: Colors.white,
  //                 alignment: Alignment.center,
  //                 height: 300,
  //                 child: Column(
  //                   // mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Spacer(),
  //                     Image.asset(Assets.assets_image_ic_fingerprint_png),
  //                     const SizedBox(
  //                       height: 30,
  //                     ),
  //                     Text('scan your figerprint',
  //                         style: TextStyle(
  //                             fontSize: 12,
  //                             fontWeight: FontWeight.w400,
  //                             color: Colors.black)),
  //                     const SizedBox(
  //                       height: 30,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           )).whenComplete(_cancelAuthentication);
  // }

  bool isOpen = false;
  // 300ms
  final result = await Future.delayed(const Duration(milliseconds: 300));

  // if (!(Platform.isIOS && maxThanIphonex)) {
  //   if (_wasShowAuthGuide) {
  //     isOpen = await authenticate(context, maxThanIphonex: maxThanIphonex);
  //     return isOpen;
  //   }
  //   return false;
  // } else {
    isOpen = await authenticate(context, maxThanIphonex: maxThanIphonex, timesLimitString: timesLimitString);
    return isOpen;
  // }
}

/// （，，，app，）
final LocalAuthentication _auth = LocalAuthentication();

Future<bool> authenticate(BuildContext context,
    {bool maxThanIphonex = false, String timesLimitString = ''}) async {
  bool authenticated = false;

  try {
    authenticated = await _auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        iOSAuthStrings: IOSAuthMessages(
          lockOut: 'Too many errors, please try later',
        ),
        useErrorDialogs: true,
        stickyAuth: true,
        biometricOnly: true);
  } on PlatformException catch (e) {
    // 6，
    // 1. ( iOSnotAvailable)
    if (e.code == auth_error.notAvailable || e.code == auth_error.notEnrolled) {
      // useErrorDialogs: true Go to settingsdialog，
      if (Platform.isIOS && maxThanIphonex) {
        showToast(S.current.enableFaceIdErrorToast);
      } else {
        showToast(S.current.enableFingerprintErrorToast);
      }
    } else if (e.code == auth_error.lockedOut ||
        e.code == auth_error.permanentlyLockedOut) {
      // 3. ，
      // showToast(S.current.security_totast2);
      if(timesLimitString.isNotEmpty) showToast(timesLimitString);
    }
  }

  // ，
  if (_wasShowAuthGuide) Navigator.pop(context);

  return authenticated;
}

/// ()
Future<bool> enableBiometrics() async {
  bool canCheckBiometrics = false;
  try {
    // 
    canCheckBiometrics = await _auth.canCheckBiometrics;
  } on PlatformException catch (e) {
    print(e);
  }
  return canCheckBiometrics;
}



// ()
Future<bool> supportedBiometrics() async {
  late bool supported;
  try {
    supported = await _auth.isDeviceSupported();
  } on PlatformException catch (e) {
    print(e);
  }
  return supported;
}

/// 
Future<List<BiometricType>?> getAvailableBiometrics() async {
  List<BiometricType>? availableBiometrics;
  try {
    availableBiometrics = await _auth.getAvailableBiometrics();
  } on PlatformException catch (e) {
    print(e);
  }
  return availableBiometrics;
}
