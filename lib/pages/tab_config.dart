enum TabConfig {
  ///
  hide,

  ///
  showAndEnable,

  ///
  showButDisable,
}

extension TabConfigExt on TabConfig {
  String get id {
    var _id = '1';
    switch (this) {
      case TabConfig.hide:
        _id = '0';
        break;
      case TabConfig.showAndEnable:
        _id = '1';
        break;
      case TabConfig.showButDisable:
        _id = '2';
        break;
    }
    return _id;
  }
}
