import 'package:sqflite/sqflite.dart';
import 'package:word_notifier/core/db/db_data.dart';
import 'package:word_notifier/core/error/exception.dart';
import 'package:word_notifier/future/data/models/card_model.dart';

import 'card_local_data_source.dart';

class CardLocalDataSourceImpl implements CardLocalDataSource {
  static const String table = AppDatabaseSettings.cardTable;
  final Database database;

  CardLocalDataSourceImpl({required this.database});

  @override
  Future<int> insert(CardModel card, int userId) async {
    if (card.userId != userId) {
      throw SecurityException();
    }
    final result = await database.insert(table, card.toJson());
    return result > 0 ? result : throw CacheException();
  }

  @override
  Future<int> update(CardModel card, int userId) async {
    if (card.userId != userId) {
      throw SecurityException();
    }
    final result = await database.update(table, card.toJson());
    return result > 0 ? result : throw CacheException();
  }

  @override
  Future<int> delete(CardModel card, int userId) async {
    if (card.userId != userId) {
      throw SecurityException();
    }
    final result = await database.delete(table, where: 'id = ?', whereArgs: [card.id]);
    return result > 0 ? result : throw CacheException();
  }

  @override
  Future<List<CardModel>> fetchAll(int userId) async {
    List<Map<String, dynamic>> result = await database.query(
      table,
      columns: ['id', 'word', 'translation', 'is_learnt', 'created_at', 'user_id'],
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return result.map((item) => CardModel.fromJson(item)).toList();
  }
}
