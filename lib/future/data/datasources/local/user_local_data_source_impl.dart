import 'package:sqflite/sqflite.dart';
import 'package:word_notifier/core/db/db_data.dart';
import 'package:word_notifier/core/error/exception.dart';
import 'package:word_notifier/future/data/datasources/local/user_local_data_source.dart';
import 'package:word_notifier/future/data/models/user_model.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const String table = AppDatabaseSettings.userTable;
  final Database database;

  UserLocalDataSourceImpl({required this.database});

  @override
  Future<int> insert(UserModel user) async {
    final result = await database.insert(
      table,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result > 0 ? result : throw CacheException();
  }

  @override
  Future<int> update(UserModel user) async {
    final result = await database.update(
      table,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result > 0 ? result : throw CacheException();
  }

  @override
  Future<int> delete(int userId) async {
    final result = await database.delete(
      table,
      where: 'id = ?',
      whereArgs: [userId],
    );
    return result > 0 ? result : throw CacheException();
  }

  @override
  Future<UserModel> fetch(int id) async {
    List<Map<String, dynamic>> result = await database.query(
      table,
      columns: ['id', 'name', 'email', 'password', 'created_at', 'is_disabled'],
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.map((item) => UserModel.fromJson(item)).first;
  }

  @override
  Future<UserModel?> fetchCurrent() async {
    List<Map<String, dynamic>> result = await database.query(table);
    return result.isNotEmpty ? result.map((item) => UserModel.fromJson(item)).first : null;
  }
}
