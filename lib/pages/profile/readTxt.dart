import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/*
* 
* */

class Storage {
  //  
  Future<String> get _localPath async {
    final _path = await getTemporaryDirectory();
    return _path.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/assets/english.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      var contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  Future<File> writeCounter(counter) async {
    final file = await _localFile;

    return file.writeAsString('$counter');
  }
}
