import 'package:sqflite/sqflite.dart';

abstract class LocalDB {
  static Database _instance;
  static Database get instance => _instance;

  static Future<void> init() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();

    // open the database
    _instance = await openDatabase(
      databasesPath + 'local.db',
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the following tables
        await db.execute(
          'CREATE TABLE Orders ('
          'id INTEGER PRIMARY KEY, '
          'orderJsonEncoded TEXT'
          ')',
        );
      },
    );
  }
}
