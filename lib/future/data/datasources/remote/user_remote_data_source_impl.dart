import 'package:word_notifier/core/error/exception.dart';
import 'package:word_notifier/future/data/datasources/remote/user_remote_data_source.dart';
import 'package:word_notifier/future/data/models/user_model.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel> fetch(int id) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<String> generateUniqueIdentifier() async {
    try {
      return 'Some_Unique_Identifier@unique.identifier';
    } catch(error) {
      throw ServerException();
    }
  }

  @override
  Future<int> insert(UserModel user) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<int> update(UserModel user) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
}