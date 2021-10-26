

extension NumExt on num {
  num truncated(int fractionDigits, [bool round = false]) {
    // var scale = pow(10, fractionDigits);
    // var truncated = ((scale * this).toInt()) / scale;
    // truncated = truncated == -0 ? 0 : truncated;
    // return truncated;
    return _numberFixed(number: this, digits: fractionDigits, round: round);
  }

  ///
  num _numberFixed(
      {required num number, required int digits, required bool round}) {
    if (digits == 0 || number == 0) return number.toInt();

    /// ,digits+1
    String res = number.toStringAsFixed(digits + (round ? 0 : 1));
    String fixedRes = res.substring(0, res.lastIndexOf('.') + digits + 1);
    return num.parse(fixedRes);
  }
}
