import 'dart:async';

import 'package:woo_english/app/data/local_database/database_const/database_const.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? db;
  static final DatabaseHelper databaseHelperInstance =
      DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    return databaseHelperInstance;
  }

  Future<Database?> openDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), DatabaseConst.databaseName),
      onCreate: (db, version) async {

        await createDatabase(db: db);
        await createUserLoginDatabase(db: db);
      },
      version: DatabaseConst.version,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < newVersion) {

            await db.execute("DROP TABLE IF EXISTS ${DatabaseConst.tableName}");
            await db.execute("DROP TABLE IF EXISTS ${DatabaseConst.tableNameUserLogin}");
            await createDatabase(db: db);
            await createUserLoginDatabase(db: db);
        }
      },
    );
    return db;
  }

  Future<void> closeDB() async {
    final db = await databaseHelperInstance.openDB();
    db?.close();
  }

  Future<void> createDatabase({required Database? db}) async {
    await db?.execute('''CREATE TABLE IF NOT EXISTS  ${DatabaseConst.tableName}
        (${DatabaseConst.columnPrimaryKey} ${DatabaseConst.idType}
        , ${DatabaseConst.columnId} ${DatabaseConst.textType}
        , ${DatabaseConst.columnName} ${DatabaseConst.textType}
        , ${DatabaseConst.columnEmail} ${DatabaseConst.textType}
        , ${DatabaseConst.columnMobile} ${DatabaseConst.textType}
        , ${DatabaseConst.columnUserImage} ${DatabaseConst.textType}
        , ${DatabaseConst.columnEmailVerifyAt} ${DatabaseConst.textType}
        , ${DatabaseConst.columnUserRole} ${DatabaseConst.textType}
        , ${DatabaseConst.columnStatus} ${DatabaseConst.textType}
        , ${DatabaseConst.columnUserId} ${DatabaseConst.textType}
        , ${DatabaseConst.columnMembershipPlan} ${DatabaseConst.textType}
        , ${DatabaseConst.columnMembershipDate} ${DatabaseConst.textType} , 
        ${DatabaseConst.columnMembershipExpireDate} ${DatabaseConst.textType}
        , ${DatabaseConst.columnIp} ${DatabaseConst.textType}
        , ${DatabaseConst.columnDeviceType} ${DatabaseConst.textType}
        , ${DatabaseConst.columnCreatedAt} ${DatabaseConst.textType}
        , ${DatabaseConst.columnUpdatedAt} ${DatabaseConst.textType}
        , ${DatabaseConst.columnToken} ${DatabaseConst.textType}
        , ${DatabaseConst.columnMyCollection} ${DatabaseConst.textType}
        , ${DatabaseConst.columnCompleteBook} ${DatabaseConst.textType}
        , ${DatabaseConst.columnOnGoing} ${DatabaseConst.textType}
        , ${DatabaseConst.columnNotificationOnOff} ${DatabaseConst.textType}
        , ${DatabaseConst.columnAppUpdateOnOff} ${DatabaseConst.textType}
        , ${DatabaseConst.columnMode} ${DatabaseConst.textType}
        , ${DatabaseConst.columnCountryCode} ${DatabaseConst.textType}
        )''');
  }

  Future<void> createUserLoginDatabase({required Database? db}) async {
    await db?.execute(
        '''CREATE TABLE IF NOT EXISTS  ${DatabaseConst.tableNameUserLogin}
        (${DatabaseConst.columIsLogIn} ${DatabaseConst.textType})''');
  }

  Future<bool> insert(
      {required Database? db,
      required Map<String, dynamic> data,
      String tableName = DatabaseConst.tableName}) async {
    int id = await db?.insert(tableName, data) ?? -1;
    if (id != -1) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> update(
      {required Database? db,
      required Map<String, dynamic> data,
      String tableName = DatabaseConst.tableName}) async {
    await db?.update(tableName, data);
  }

  Future<String> getParticularData(
      {required String key, String tableName = DatabaseConst.tableName}) async {
    db = await openDB();
    if (!await isDatabaseHaveData(db: db, tableName: tableName)) {
      List<Map<String, Object?>> listOfData =
          await db?.rawQuery('SELECT * FROM $tableName') ?? [];
      return listOfData.first[key].toString();
    } else {
      return "";
    }
  }

  Future<void> updateParticularData(
      {required String key,
      required String val,
      String tableName = DatabaseConst.tableName}) async {
    db = await openDB();
    Map<String, dynamic> value = {};
    value = {key: val};
    await db?.update(tableName, value,
            where: '${DatabaseConst.columnPrimaryKey} = ?', whereArgs: [1]) ??
        [];
  }

  Future<bool> isDatabaseHaveData(
      {required Database? db,
      String tableName = DatabaseConst.tableName}) async {
    List<Map<String, Object?>> listOfData =
        await db?.rawQuery('SELECT * FROM $tableName') ?? [];
    if (listOfData.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> delete(
      {required Database? db,
      String tableName = DatabaseConst.tableName}) async {
    int id = await db?.delete(tableName) ?? -1;
    if (id != -1) {
      return true;
    } else {
      return false;
    }
  }
}
