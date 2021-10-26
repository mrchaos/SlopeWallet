import 'package:wallet/pages/login_wallet/EnglishMnemonice.dart';

class DisposeArray {
//  
  static removeEmpty({required List<String> list}) {
    list.removeWhere((element) => element.isEmpty);
    return list;
  }

  /// 
  static Map extractFirstWordList() {
    Map<String, List<String>> newlist = {};
    word.forEach((element) {
      newlist[element] = [];
      MnmoniceListData.forEach((item) {
        if (item[0] == element) {
          newlist[element]!.add(item);
        }
      });
    });
    return newlist;
  }

  /// 
  reduceDimension({required List arr}) {
    List data = [];
    for (var item in arr) {
      // print(arr);
      data.addAll(item);
    }
    return data;
  }
}

final word = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];
