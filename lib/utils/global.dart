import 'dart:ui';

enum UserSystemFlow {
  flowRegister, // 'reg'
  flowForgot, // 'forget_pwd'
  flowChangePwd, // 'update_pwd'
  flowChangeMobile, // 'update_phone'
  flowChangeEmail, // 'update_phone'
  flowChangePwdOld, //
  // flowChangePwdNew, //
  flowAlertBindEmail, //
  flowLogin, //
}

enum UserType { typeOfEmail, typeOfPhone }

class G {
  static Locale? appLocale;

  //
  static String? language = appLocale?.languageCode.toLowerCase();

  ///
  static bool get isChineseLanguage =>
      appLocale?.languageCode.toLowerCase() == 'zh';

  //
  static const int kickError = 1012101;

  // livedemo，
  static bool isSwitching = false;

  ///header
  static const String kNeedRemoveHeader = 'APP_kNeedRemoveHeader';

  //
  static bool wasCheckSystemError = false;
  static DateTime? dtCheckSystemError;

  // launchid，"【】："
  static String? launchMsgId;

  static int getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    hexColor = hexColor.replaceAll('0X', '');
    if (hexColor.length == 3) {
      hexColor += hexColor;
    }
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  static Color hex(String hexColor) {
    return Color(getColorFromHex(hexColor));
  }

  static String splitMobile(String? code) {
    if (code == null || 0 == code.length) return '';
    int length = code.length;
    if (length <= 4) return code;
    String sLast = code.substring(length - 4, length);
    String sMid = "***";
    if (length > 7 && length != 9) sMid = "****";
    String sFront = code.substring(0, length - 4 - sMid.length);
    return sFront + sMid + sLast;
  }

  // @xxx.com ，，
  static String splitEmail(String? code) {
    if (code == null || 0 == code.length) return '';
    int length = code.length;
    String result = code;
    int indexAt = code.indexOf("@");
    if (0 > indexAt) return '';
    String sLast = code.substring(indexAt, length);
    String sFront = code.substring(0, indexAt);
    String sMid = "***";
    if (indexAt > 3) {
      sFront = code.substring(0, 3);
    } else {
      if (1 == indexAt) {
        sFront = code.substring(0, 1);
        sMid = '';
      } else if (2 == indexAt) {
        sFront = code.substring(0, 1);
        sMid = '*';
      } else if (3 == indexAt) {
        sFront = code.substring(0, 1);
        sMid = '**';
      }
    }
    return sFront + sMid + sLast;
  }

  static String deviceVersion(String version) {
    if (version == 'iPhone3,1') return 'iPhone 4';
    if (version == 'iPhone3,2') return 'iPhone 4';
    if (version == 'iPhone3,3') return 'iPhone 4';
    if (version == 'iPhone4,1') return 'iPhone 4S';
    if (version == 'iPhone5,1') return 'iPhone 5';
    if (version == 'iPhone5,2') return 'iPhone 5 (GSM+CDMA)';
    if (version == 'iPhone5,3') return 'iPhone 5C (GSM)';
    if (version == 'iPhone5,4') return 'iPhone 5C (GSM+CDMA)';
    if (version == 'iPhone6,1') return 'iPhone 5S (GSM)';
    if (version == 'iPhone6,2') return 'iPhone 5S (GSM+CDMA)';
    if (version == 'iPhone7,1') return 'iPhone 6 Plus';
    if (version == 'iPhone7,2') return 'iPhone 6';
    if (version == 'iPhone8,1') return 'iPhone 6s';
    if (version == 'iPhone8,2') return 'iPhone 6s Plus';
    if (version == 'iPhone8,4') return 'iPhone SE';
    // ，FeliCa
    if (version == 'iPhone9,1') return 'iPhone 7';
    if (version == 'iPhone9,2') return 'iPhone 7 Plus';
    if (version == 'iPhone9,3') return 'iPhone 7';
    if (version == 'iPhone9,4') return 'iPhone 7 Plus';
    if (version == 'iPhone10,1') return 'iPhone 8';
    if (version == 'iPhone10,4') return 'iPhone 8';
    if (version == 'iPhone10,2') return 'iPhone 8 Plus';
    if (version == 'iPhone10,5') return 'iPhone 8 Plus';
    if (version == 'iPhone10,3') return 'iPhone X';
    if (version == 'iPhone10,6') return 'iPhone X';
    if (version == 'iPhone11,8') return 'iPhone XR';
    if (version == 'iPhone11,2') return 'iPhone XS';
    if (version == 'iPhone11,4') return 'iPhone XSMax';
    if (version == 'i386') return 'Simulator';
    if (version == 'x86_64') return 'Simulator';
    return 'unknow device!';
  }

  static bool deviceMaxThanIPhoneX(String? version) {
    if ((version == 'iPhone3,1') ||
        (version == 'iPhone3,2') ||
        (version == 'iPhone3,3') ||
        (version == 'iPhone4,1') ||
        (version == 'iPhone5,1') ||
        (version == 'iPhone5,2') ||
        (version == 'iPhone5,3') ||
        (version == 'iPhone5,4') ||
        (version == 'iPhone6,1') ||
        (version == 'iPhone6,2') ||
        (version == 'iPhone7,1') ||
        (version == 'iPhone7,2') ||
        (version == 'iPhone8,1') ||
        (version == 'iPhone8,2') ||
        (version == 'iPhone8,4') ||
        (version == 'iPhone9,1') ||
        (version == 'iPhone9,2') ||
        (version == 'iPhone9,3') ||
        (version == 'iPhone9,4') ||
        (version == 'iPhone10,1') ||
        (version == 'iPhone10,4') ||
        (version == 'iPhone10,2') ||
        (version == 'iPhone10,5')) {
      return false;
    }
    return true;
  }

  // Text，，overflow: TextOverflow.ellipsis,
  // ：
  // ： YD-YXTJA-2102217-001113123123123123123，：YD-…
  // ：
  // static String breakWord(String word) {
  //   if (word == null || word.isEmpty) {
  //     return word;
  //   }
  //   String breakWord = ' ';
  //   word.runes.forEach((element) {
  //     breakWord += String.fromCharCode(element);
  //     breakWord += '\u200B';
  //   });
  //   return breakWord;
  // }
}
