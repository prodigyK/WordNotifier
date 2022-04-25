import 'package:word_notifier/future/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<int> insert(UserModel user);

  Future<UserModel> fetch(int id);

  Future<int> update(UserModel user);

  Future<String> generateUniqueIdentifier();
}