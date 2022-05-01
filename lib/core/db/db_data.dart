import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseSettings {
  AppDatabaseSettings._();

  static const int versionDb = 1;
  static const int versionDictDb = 1;

  static const String userTable = 'users';
  static const String cardTable = 'cards';
  static const String dictionaryTable = 'dictionary';

  static Future<Database> openDB() async {
    const String dbName = 'wordify.db';
    return await openDatabase(
      join(await getDatabasesPath(), dbName),
      version: versionDb,
      onCreate: _createTables,
    );
  }

  static Future<Database> openDictionaryDB() async {
    const String dbName = 'dictionary.db';
    return await openDatabase(
      join(await getDatabasesPath(), dbName),
      version: versionDictDb,
      onCreate: _createDictionaryTable,
    );
  }

  static _createTables(Database database, int versionDb) async {
    await database.transaction((txn) async {
      await txn.execute(createUserTable);
      await txn.execute(createCardTable);
    });
  }

  static _createDictionaryTable(Database database, int versionDb) async {
    await database.execute(createDictionaryTable);
  }

  static const String createDictionaryTable = ''
      'CREATE TABLE $dictionaryTable('
      'id INTEGER PRIMARY KEY, '
      'word TEXT, '
      'translation TEXT, '
      'transcription TEXT,'
      'direction TEXT'
      ')';

  static const String createUserTable = ''
      'CREATE TABLE $userTable('
      'id INTEGER PRIMARY KEY, '
      'name TEXT, '
      'email TEXT, '
      'password TEXT,'
      'created_at TIMESTAMP,'
      'is_disabled INTEGER'
      ')';

  static const String createCardTable = ''
      'CREATE TABLE $cardTable('
      'id INTEGER PRIMARY KEY, '
      'word TEXT, '
      'translation TEXT, '
      'is_learnt INTEGER,'
      'created_at TIMESTAMP,'
      'user_id INTEGER'
      ')';
}
