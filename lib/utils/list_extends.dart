class ListExtends {
  /// List
  /// baseArray
  /// count ，
  static List<List<T>> ListExtend<T>(List<T>  arr, int size) {
    List<List<T>> newList = [];
    for (var i = 0; i< arr.length; i+=size) {

      if (arr.length - i > size) {
        List<T> childArr = [];
        for(var j = 0; j<size; j++ ) {
          childArr.add(arr[i+j]);
        }
        newList.add(childArr);
      } else {
        List<T> childArr = [];
        for(var j = 0; j<arr.length - i; j++ ) {
          childArr.add(arr[i+j]);
        }
        newList.add(childArr);
      }
    }
    return newList;
  }
}

main() {
  var li = [1, 2, 3, 4, 5, 6, 7];
  print(ListExtends.ListExtend<int>(li, 6));
}
