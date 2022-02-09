import 'package:sqflite/sqflite.dart';
import 'package:word_notifier/core/db/db_data.dart';
import 'package:word_notifier/core/error/exception.dart';
import 'package:word_notifier/future/data/datasources/local/dictionary/dictionary_local_data_source.dart';
import 'package:word_notifier/future/data/models/dictionary_model.dart';

class DictionaryLocalDataSourceImpl implements DictionaryLocalDataSource {
  static const String table = AppDatabaseSettings.dictionaryTable;

  final Database database;
  DictionaryLocalDataSourceImpl({required this.database});

  @override
  Future<int> insert(DictionaryModel dict) async {
    final result = await database.insert(table, dict.toJson());
    return result > 0 ? result : throw CacheException();
  }

  @override
  Future<List<DictionaryModel>> search(String query) async {
    List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT id, word, translation, transcription, direction '
      'FROM $table '
      'WHERE word LIKE "$query"%',
    );
    return result.map((item) => DictionaryModel.fromJson(item)).toList();
  }
}
