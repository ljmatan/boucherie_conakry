import 'package:sqflite/sqflite.dart';

abstract class LocalDB {
  static Database _db;
  static Database get db => _db;

  static Future<void> init() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();

    // open the database
    _db = await openDatabase(
      databasesPath + 'local.db',
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the following tables
        await db.execute(
          'CREATE TABLE Current ('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'value INTEGER, '
          'num REAL'
          ')',
        );
      },
    );
  }
}
