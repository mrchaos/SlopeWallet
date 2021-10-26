import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet/wallet_manager/database/web_wallet_database.dart';
import 'package:wallet/wallet_manager/data/wallet_entity.dart';
import 'package:wd_common_package/wd_common_package.dart';

import 'database_interface.dart';

final walletDatabase = kIsWeb ? WebWalletDatabase() : DefaultWalletDatabase();

class DefaultWalletDatabase implements WalletDatabaseInterface {
  factory DefaultWalletDatabase() => _getInstance();

  static DefaultWalletDatabase get instance => _getInstance();
  static DefaultWalletDatabase? _instance;

  DefaultWalletDatabase._internal();

  static DefaultWalletDatabase _getInstance() =>
      _instance ?? DefaultWalletDatabase._internal();

  ///
  final int dbVersion = 1;

  static const String _walletDBName = "database  name ";

  ///
  CREATE TABLE IF NOT EXISTS $_walletTableName (
      '''
      ''';

  static Database? _database;

  Future<Database> get database async {
    if (null != _database) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), _walletDBName);
    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  void _onCreate(Database db, int version) async {
    var batch = db.batch();
    _createTableWalletV1(batch);
    await batch.commit();
    logger.d('table is created');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // var batch = db.batch();
    // if(oldVersion == 1){
    //   _upgradeTableWalletV1toV2(batch);
    // }
    // await batch.commit();
  }

  void _createTableWalletV1(Batch batch) {
    batch.execute(_tableWalletV1);
  }

  /// sample
  ///
  /// V1->V2,isMain bool
  void _upgradeTableWalletV1toV2(Batch batch) {
    batch.execute('ALTER TABLE $_walletTableName ADD isMain BOOL');
  }

  ///
  @override
  Future<dynamic> insertWallet({required WalletEntity walletEntity}) async {
    final db = await database;
    /// ,
    var entityMap = walletEntity.encrypt();
    await db.insert(
      _walletTableName,
      entityMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return Future.value();
  }



  ///
  @override
  Future<int> deleteWallet({required WalletEntity walletEntity}) async {
    final db = await database;
    String walletId = walletEntity.walletId;
    return db.delete(_walletTableName,
        where: "$_walletId = ?", whereArgs: [walletId]);
  }

  ///
  ///
  /// [walletEntity]
  @override
  Future<int> updateWallet({required WalletEntity walletEntity}) async {
    final db = await database;
    var entityMap = walletEntity.toJson();
    return db.update(_walletTableName, entityMap,
        where: "$_address = ?", whereArgs: [walletEntity.address]);
  }

  ///
  @override
  Future<List<WalletEntity>> queryAllWallet() async {
    final db = await database;
    var result = await db.query(_walletTableName);
    List<WalletEntity> entities = [];
    result.forEach((element) {
      entities.add(WalletEntity.fromJson(element));
    });
    return entities;
  }

  /// blockChain
  @override
  Future<List<WalletEntity>> queryWalletByBlockChain(
      {required String blockChain}) async {
    final db = await database;
    var result = await db.query(_walletTableName,
        where: '$_blockChain = ?', whereArgs: [blockChain]);
    List<WalletEntity> entities = [];
    result.forEach((element) {
      entities.add(WalletEntity.fromJson(element));
    });
    return entities;
  }

  /// (,)
  @override
  Future<List<WalletEntity>> queryWalletByMnemonic(
 //todo
    return [];
  }

  /// walletId
  @override
  Future<WalletEntity?> queryWalletByWalletId(
      {required String walletId}) async {
    final db = await database;
    var result = await db.query(_walletTableName,
        where: '$_walletId = ?', whereArgs: [walletId]);
    if (result.isNotEmpty) {
      return WalletEntity.fromJson(result.first);
    }
    return null;
  }

  /// walletName
  @override
  Future<WalletEntity?> queryWalletByWalletName(
      {required String walletName}) async {
    final db = await database;
    var result = await db.query(_walletTableName,
        where: '$_walletName = ?', whereArgs: [walletName]);
    if (result.isNotEmpty) {
      return WalletEntity.fromJson(result.first);
    }
    return null;
  }

  /// walletName
  ///
  /// true, false
  @override
  Future<bool> checkWalletNameIsExist({required String walletName}) async {
    final db = await database;
    var result = await db.query(_walletTableName,
        where: '$_walletName = ?', whereArgs: [walletName]);
    return Future.value(result.isNotEmpty);
  }


  @override
  Future deleteAllWallet() async {
    final db = await database;
    await db.delete(_walletTableName);
    await db.close();
    _database = null;
    return Future.value();
  }
}
