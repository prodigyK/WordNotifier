import 'package:sqflite/sqflite.dart';
import 'package:word_notifier/core/db/db_data.dart';
import 'package:word_notifier/future/data/models/card_model.dart';

import 'card_local_data_source.dart';

class CardLocalDataSourceImpl implements CardLocalDataSource {
  static const String table = AppDatabaseSettings.cardTable;
  final Database database;

  CardLocalDataSourceImpl({required this.database});

  @override
  Future<int> insert(CardModel user) async {
    return await database.insert(table, user.toJson());
  }

  @override
  Future<int> update(CardModel user) async {
    return await database.update(table, user.toJson());
  }

  @override
  Future<int> delete(int userId) {
    return database.delete(table, where: 'id = ?', whereArgs: [userId]);
  }

  @override
  Future<CardModel> fetch(int id) async {
    List<Map<String, dynamic>> result = await database.query(
      table,
      columns: ['id', 'word', 'translation', 'is_learnt', 'created_at', 'user_id'],
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.map((item) => CardModel.fromJson(item)).first;
  }
}
