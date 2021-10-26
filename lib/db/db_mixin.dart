import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

mixin DbMixin {
  static Database? _database;

  ///db
  String get dbName;

  ///
  int get dbVersion;

  Future<void> onConfigure(Database db) async {}

  Future<void> onCreate(Database db, int version);

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {}

  Future<void> onDowngrade(Database db, int oldVersion, int newVersion) async {}

  Future<void> onOpen(Database db) async {}

  ///。
  Future<Database> get database async {
    if (null != _database) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  ///
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    var database = await openDatabase(
      path,
      version: dbVersion,
      onConfigure: onConfigure,
      onCreate: onCreate,
      onUpgrade: onUpgrade,
      onDowngrade: onDowngrade,
    );
    return database;
  }
}

mixin TableMixin on DbMixin {}
