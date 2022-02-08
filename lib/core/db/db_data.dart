import 'package:dotenv/dotenv.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseSettings {
  AppDatabaseSettings._();

  static const int versionDb = 1;
  static const int versionDictDb = 1;

  static const String userTable = 'users';
  static const String cardTable = 'cards';

  static Future<Database> openDB() async {
    final String dbName = env['userdata_db'] ?? 'temp.db';
    return await openDatabase(dbName, version: versionDb, onCreate: _createTables);
  }

  static Future<Database> openDictionaryDB() async {
    final String dbName = env['dictionary_db'] ?? 'dict_temp.db';
    return await openDatabase(dbName, version: versionDictDb, onCreate: _createDictionaryTable);
  }

  static _createTables(Database database, int versionDb) async {
    await database.transaction((txn) async {
      txn.execute(createUserTable);
      txn.execute(createCardTable);
    });
  }
  
  static _createDictionaryTable(Database database, int versionDb) async {
    await database.execute(createDictionaryTable);
  }

  static const String createDictionaryTable = ''
      'CREATE TABLE $userTable('
        'id INTEGER PRIMARY KEY, '
        'word TEXT, '
        'translation TEXT, '
        'transcription TEXT,'
        'direction TEXT,'
      ')';

  static const String createUserTable = ''
      'CREATE TABLE $userTable('
        'id INTEGER PRIMARY KEY, '
        'name TEXT, '
        'email TEXT, '
        'password TEXT,'
        'created_at TIMESTAMP,'
        'is_disabled REAL'
      ')';

  static const String createCardTable = ''
      'CREATE TABLE $cardTable('
        'id INTEGER PRIMARY KEY, '
        'word TEXT, '
        'translation TEXT, '
        'is_learnt REAL,'
        'created_at TIMESTAMP,'
        'user_id REAL'
      ')';

}

