import 'package:dartz/dartz.dart';
import 'package:word_notifier/core/error/exception.dart';
import 'package:word_notifier/core/error/failure.dart';
import 'package:word_notifier/future/data/datasources/remote/user_remote_data_source.dart';
import 'package:word_notifier/future/domain/repositories/remote/user_remote_repository.dart';

class UserRemoteRepositoryImpl implements UserRemoteRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRemoteRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, String>> generateUniqueIdentifier() async {
    try {
      final result = await userRemoteDataSource.generateUniqueIdentifier();
      if (result.isEmpty) {
        throw ServerException();
      }
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
