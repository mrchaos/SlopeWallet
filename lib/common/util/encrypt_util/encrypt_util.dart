import 'dart:convert';

import 'package:crypto/crypto.dart';

class EncryptUtil {
  /// md5
  static String md5Encrypt(Map<String, dynamic>? params) {
    //Encrypt params
    final md5String = md5.convert(utf8.encode(key)).toString();
    return md5String;
  }
}
