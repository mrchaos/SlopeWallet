import 'package:intl/intl.dart';

//APP ，
const kAppCurrencyLocal = 'en_US';

///APP  
const kAppCurrencyDecimalDigits = 2;

///APP
class AppNumberFormat {
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
      NumberFormat.decimalPercentPattern(
          locale: locale, decimalDigits: decimalDigits);

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
