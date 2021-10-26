import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';
import 'package:intl/intl.dart';

//APP ，
const kAppCurrencyLocal = 'en_US';

///APP
const kAppCurrencyDecimalDigits = 2;
const kMaxDecimalDigits = 6;

///APP
class CurrencyFormat {
  ///
  static String formatBalance(num balance) {
    if (balance == balance.toInt()) {
      balance = balance.toInt();
    }
    var string = balance.toString();
    if (string.contains(r'e')) {
      var split = string.split('e');
      var digits = int.parse(split[1]);

      if (digits < 0) {
        digits = digits.abs();
        if (split[0].split(r'.').length > 1) {
          digits = digits + split[0].split(r'.')[1].length;
        }
      }
      string = NumberFormat.simpleCurrency(
        name: '',
        decimalDigits: digits,
      ).format(balance);

      string = string.replaceAll(r',', '');
    }

    return string;
  }

  static String formatDecimal(Decimal value, {int? maxDecimalDigits}) {
    var str = value.toString();
    var format = NumberFormat.decimalPattern();
    if (str.contains(r'.')) {
      int digits = str.split(r'.')[1].length;

      if (null != maxDecimalDigits && maxDecimalDigits >= 0) {
        digits = min(digits, maxDecimalDigits);
      }
      format.maximumFractionDigits = digits;
    }

    str = format.format(DecimalIntl(value));

    while (str.contains(r'.') && str.endsWith(r'0')) {
      //0
      str = str.substring(0, str.length - 1);
    }

    if (str.endsWith(r'.')) {
      str = str.substring(0, str.length - 1);
    }
    return str;
  }

  ///USDT，
  static String formatUSDT(Decimal ustd, {int maxDecimalDigits = kMaxDecimalDigits}) {
    return formatDecimal(ustd, maxDecimalDigits: maxDecimalDigits);
  }

  static NumberFormat decimalPattern([String locale = kAppCurrencyLocal]) =>
      NumberFormat.decimalPattern(locale);

  /// Create a number format that prints as PERCENT_PATTERN.
  static NumberFormat percentPattern([String locale = kAppCurrencyLocal]) =>
      NumberFormat.percentPattern(locale);

  /// Create a number format that prints as PERCENT_PATTERN.
  static NumberFormat decimalPercentPattern({
    String locale = kAppCurrencyLocal,
    int decimalDigits = kAppCurrencyDecimalDigits,
  }) =>
      NumberFormat.decimalPercentPattern(locale: locale, decimalDigits: decimalDigits);

  /// Create a number format that prints as SCIENTIFIC_PATTERN.
  static NumberFormat scientificPattern([String locale = kAppCurrencyLocal]) =>
      NumberFormat.scientificPattern(kAppCurrencyLocal);

  @Deprecated('Use CurrencyFormat.currency')
  static NumberFormat currencyPattern(
          [String locale = kAppCurrencyLocal, String? currencyNameOrSymbol]) =>
      NumberFormat.currencyPattern(locale, currencyNameOrSymbol);

  static NumberFormat currency({
    String locale = kAppCurrencyLocal,
    String? name,
    String? symbol,
    int? decimalDigits = kAppCurrencyDecimalDigits,
    String? customPattern,
  }) =>
      NumberFormat.currency(
        locale: locale,
        name: name,
        symbol: symbol,
        decimalDigits: decimalDigits,
        customPattern: customPattern,
      );

  static NumberFormat simpleCurrency({
    String locale = kAppCurrencyLocal,
    String? name,
    int decimalDigits = kAppCurrencyDecimalDigits,
  }) =>
      NumberFormat.simpleCurrency(
        locale: locale,
        name: name,
        decimalDigits: decimalDigits,
      );

  static NumberFormat compact({
    String locale = kAppCurrencyLocal,
  }) =>
      NumberFormat.compact(
        locale: locale,
      );

  static NumberFormat compactLong({
    String locale = kAppCurrencyLocal,
  }) =>
      NumberFormat.compactLong(
        locale: locale,
      );

  static NumberFormat compactSimpleCurrency({
    String locale = kAppCurrencyLocal,
    String? name,
    int decimalDigits = kAppCurrencyDecimalDigits,
  }) =>
      NumberFormat.compactSimpleCurrency(
        locale: locale,
        name: name,
        decimalDigits: decimalDigits,
      );

  static NumberFormat compactCurrency(
          {String locale = kAppCurrencyLocal,
          String? name,
          String? symbol,
          int decimalDigits = kAppCurrencyDecimalDigits}) =>
      NumberFormat.compactCurrency(
        locale: locale,
        name: name,
        symbol: symbol,
        decimalDigits: decimalDigits,
      );
}
