import 'package:sqflite/sqflite.dart';
import 'package:word_notifier/core/db/db_data.dart';
import 'package:word_notifier/future/data/datasources/local/user_local_data_source.dart';
import 'package:word_notifier/future/data/models/user_model.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  static const String table = AppDatabaseSettings.userTable;
  final Database database;

  UserLocalDataSourceImpl({required this.database});

  @override
  Future<int> insert(UserModel user) async {
    return await database.insert(table, user.toJson());
  }

  @override
  Future<int> update(UserModel user) async {
    return await database.update(table, user.toJson());
  }

  @override
  Future<int> delete(int userId) {
    return database.delete(table, where: 'id = ?', whereArgs: [userId]);
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
}
