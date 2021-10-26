import 'dart:math';

import 'package:flutter/foundation.dart';

/// The smallest possible value of an int within 64 bits.
final int64MinValue = kIsWeb
    ? BigInt.parse('-9223372036854775808')
    : int.parse('-9223372036854775808');

/// The biggest possible value of an int within 64 bits.
final int64MaxValue = kIsWeb
    ? BigInt.parse('9223372036854775807')
    : int.parse('9223372036854775807');

///see: https://pub.flutter-io.cn/packages/number_precision
class NP {
  NP._();

  static bool _boundaryCheckingState = true;

  /// [num]
  /// [number] 
  static num parseNum(dynamic number) {
    if (number is num) {
      return number;
    } else if (number is String) {
      return num.parse(number);
    } else {
      throw FormatException('$number is not of type num and String');
    }
  }

  /// 
  /// strip(0.09999999999999998)=0.1
  /// [number]  [precision] 
  static num strip(dynamic number, {int precision = 14}) {
    return num.parse(parseNum(number).toStringAsFixed(precision));
  }

  /// 
  /// [number] 
  static int digitLength(dynamic number) {
    final eSplit = parseNum(number).toString().toLowerCase().split('e');
    final digit = eSplit[0].split('.');
    final len = (digit.length == 2 ? digit[1].length : 0) -
        (eSplit.length == 2 ? int.parse(eSplit[1]) : 0);
    return len > 0 ? len : 0;
  }

  /// ，。
  /// [number] 
  static num float2Fixed(dynamic number) {
    final dLen = digitLength(number);
    if (dLen <= 20) {
      if (number is String) {
        if (number.toLowerCase().indexOf('e') == -1) {
          return num.parse(number.replaceAll('.', ''));
        }
        return num.parse(num.parse(number)
            .toStringAsFixed(dLen)
            .replaceAll(dLen == 0 ? '' : '.', ''));
      } else if (number is num) {
        return num.parse(
            number.toStringAsFixed(dLen).replaceAll(dLen == 0 ? '' : '.', ''));
      }

      throw FormatException('$number is not of type num and String');
    }
    throw Exception(
        '$number is beyond boundary when transfer to integer, the results may not be accurate');
  }

  /// ，
  /// [number] 
  static void checkBoundary(dynamic number) {
    if (_boundaryCheckingState) {
      if (number is num) {
        late var res;
        if (kIsWeb) {
          res = BigInt.from(number);
        } else {
          res = number;
        }

        if (res > int64MaxValue || res < int64MinValue) {
          throw Exception(
              '$number is beyond boundary when transfer to integer, the results may not be accurate');
        }
      }

    }
  }

  /// 
  /// [num1]  [num2]
  /// [others] 
  ///
  ///  times(1, 2, [22,33])
  static num times(dynamic num1, dynamic num2, [List<dynamic>? others]) {
    if (others != null) {
      return times(times(num1, num2), others[0],
          others.length >= 2 ? others.sublist(1) : null);
    }
    num num1Changed = float2Fixed(num1);
    num num2Changed = float2Fixed(num2);
    num baseNum = digitLength(num1) + digitLength(num2);
    num leftValue = num1Changed * num2Changed;

    checkBoundary(leftValue);

    // if (leftValue.toString().length + baseNum < 20) {
    return NP.strip(leftValue / pow(10, baseNum));
    // } else {
    //   return NP.strip(num.parse('${leftValue}e-$baseNum'));
    // }
  }

  /// 
  static num plus(dynamic num1, dynamic num2, [List<dynamic>? others]) {
    if (others != null) {
      return plus(plus(num1, num2), others[0],
          others.length >= 2 ? others.sublist(1) : null);
    }
    num baseNum = pow(10, max(digitLength(num1), digitLength(num2)));
    return (times(num1, baseNum) + times(num2, baseNum)) / baseNum;
  }

  /// 
  static num minus(dynamic num1, dynamic num2, [List<dynamic>? others]) {
    if (others != null) {
      return minus(minus(num1, num2), others[0],
          others.length >= 2 ? others.sublist(1) : null);
    }
    num baseNum = pow(10, max(digitLength(num1), digitLength(num2)));

    return (times(num1, baseNum) - times(num2, baseNum)) / baseNum;
  }

  /// 
  static num divide(dynamic num1, dynamic num2, [List<dynamic>? others]) {
    if (others != null) {
      return divide(divide(num1, num2), others[0],
          others.length >= 2 ? others.sublist(1) : null);
    }
    num num1Changed = float2Fixed(num1);
    num num2Changed = float2Fixed(num2);
    checkBoundary(num1Changed);
    checkBoundary(num2Changed);
    return times(num1Changed / num2Changed,
        (pow(10, digitLength(num2) - digitLength(num1))));
  }

  /// 
  /// * [number] 
  /// * [ratio] 
  static num round(dynamic number, int ratio) {
    num base = pow(10, ratio);
    //  [times] 
    number = parseNum(parseNum(number).toStringAsFixed(ratio + 2));
    return divide((times(number, base).round()), base);
  }

  /// ，
  /// [flag] ，true ，false ， true
  static void enableBoundaryChecking([flag = true]) {
    _boundaryCheckingState = flag;
  }
}
