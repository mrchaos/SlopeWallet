class StringEtend {
  /// ，...
  ///
  /// splitLength：;
  /// str:
   static String splitList (String str, int splitLength) {
    String newStr = '';
    if (str.length >= splitLength) {
      newStr = str.substring(0, splitLength);
      newStr ='$newStr...';
    } else {
      newStr = str;
    }
    return newStr;
  }
}
