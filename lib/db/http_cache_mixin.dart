import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import 'db_mixin.dart';

class _CacheColumns {
  _CacheColumns._();

  static const url = 'url';
  static const params = 'params';
  static const data = 'data';
}

/// Market
mixin HttpCacheTableMixin on TableMixin {
  static const String _HttpCacheTableName = "http_cache";

  void createHttpCacheTable(Batch batch) {
    batch.execute('''
      CREATE TABLE IF NOT EXISTS $_HttpCacheTableName (
        ${_CacheColumns.url} TEXT PRIMARY KEY,
        ${_CacheColumns.params} TEXT,
        ${_CacheColumns.data} TEXT
      );
    ''');
  }

  Future<void> insert(Map<String, dynamic> data) async {
    if (data.isEmpty) return;
    final db = await database;
    final batch = db.batch();
    //.
    // batch.delete(_marketTableName);
    batch.insert(
      _HttpCacheTableName,
      {
        _CacheColumns.url: data[_CacheColumns.url],
        _CacheColumns.params: jsonEncode(data[_CacheColumns.params]),
        _CacheColumns.data: data[_CacheColumns.data],
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    var list = await batch.commit(noResult: true);
  }

  /// Market
  Future<String?> queryCache(String url, {String? params}) async {
    final db = await database;
    List<Map<String, Object?>> list;
    if (params != null && params.isNotEmpty && params != 'null') {
      list = await db.query(_HttpCacheTableName,
          where: '${_CacheColumns.url} = ? AND ${_CacheColumns.params} = ?',
          whereArgs: [url, params]);
    } else {
      list = await db.query(_HttpCacheTableName,
          where: '${_CacheColumns.url} = ?', whereArgs: [url]);
    }
    if (list.isNotEmpty) {
      return list.first[_CacheColumns.data] as String;
    } else {
      return null;
    }
  }
}
