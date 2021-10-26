
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

///
///：。 5++2
class NumberLengthFilterTextInputFormatter extends TextInputFormatter {
  NumberLengthFilterTextInputFormatter({
    int intMaxLength = 5,
    int decimalDigitsMaxLength = 2,
  })  : assert(intMaxLength >= 1),
        assert(decimalDigitsMaxLength >= 0),
        this.intMaxLength = intMaxLength,
        this.decimalDigitsMaxLength = decimalDigitsMaxLength;

  ///
  final int intMaxLength;

  ///
  final int decimalDigitsMaxLength;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String? correctInput;

    if (oldValue.text.isEmpty && newValue.text == '.') {
      correctInput = '0.';
    } else if (newValue.text.isNotEmpty &&
        newValue.text == '0' * newValue.text.length) {
      //00，0
      correctInput = '0';
    } else if (newValue.text.characters.where((char) => char == '.').length >
        1) {
      if (oldValue.text.contains(r'.')) {
        newValue = oldValue;
      } else {
        //2
        final secondDotIndex =
        newValue.text.indexOf(r'.', newValue.text.indexOf(r'.') + 1);
        correctInput = newValue.text.substring(0, secondDotIndex);
      }
    } else {
      final lastDotIndex = newValue.text.lastIndexOf(r'.');
      if (lastDotIndex >= 0 && (lastDotIndex + 1) < newValue.text.length) {
        //
        if (newValue.text.substring(lastDotIndex + 1).length >
            decimalDigitsMaxLength) {
          correctInput = newValue.text
              .substring(0, lastDotIndex + decimalDigitsMaxLength + 1);
        }
      }

      if (null == correctInput) {
        var valueNum = num.tryParse(newValue.text) ?? 0;
        //
        var intString = valueNum.toInt().toString();
        if (intString.length > intMaxLength) {
          newValue = oldValue;
          //
          // correctInput = intString.substring(0, intMaxLength);
        }
      }
    }

    if (correctInput != null) {
      newValue = TextEditingValue(
        text: correctInput,
        selection: TextSelection.fromPosition(TextPosition(
          affinity: TextAffinity.downstream,
          offset: correctInput.length,
        )),
      );
    }

    return newValue;
  }
}
