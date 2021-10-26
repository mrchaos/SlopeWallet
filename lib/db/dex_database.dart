import 'package:sqflite/sqflite.dart';
import 'package:wallet/db/http_cache_mixin.dart';

import 'db_mixin.dart';

///Dex APP 
class DexDatabase with DbMixin, TableMixin,HttpCacheTableMixin {
  DexDatabase._();

  static DexDatabase? _instance;

  @override
  String get dbName => "you database name";

  static DexDatabase get instance {
    if (null == _instance) {
      _instance = DexDatabase._();
    }
    return _instance!;
  }

  /// 
  @override
  int get dbVersion => 3;

  @override
  Future<void> onCreate(Database db, int version) async {
    var batch = db.batch();
    createHttpCacheTable(batch);
    await batch.commit();
  }
}
