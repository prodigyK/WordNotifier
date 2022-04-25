import 'package:dartz/dartz.dart';
import 'package:word_notifier/core/error/exception.dart';
import 'package:word_notifier/core/error/failure.dart';
import 'package:word_notifier/future/data/datasources/local/user_local_data_source.dart';
import 'package:word_notifier/future/data/models/user_model.dart';
import 'package:word_notifier/future/domain/entities/user_entity.dart';
import 'package:word_notifier/future/domain/repositories/user_local_repository.dart';

class UserLocalRepositoryImpl implements UserLocalRepository {
  final UserLocalDataSource userLocalDataSource;

  const UserLocalRepositoryImpl({required this.userLocalDataSource});

  @override
  Future<Either<Failure, int>> insert(UserEntity user) async {
    try {
      final response = await userLocalDataSource.insert(UserModel.fromEntity(user));
      if (response <= 0) {
        throw CacheFailure();
      }
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> update(UserEntity user) async {
    try {
      final response = await userLocalDataSource.update(UserModel.fromEntity(user));
      if (response <= 0) {
        throw CacheFailure();
      }
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> fetch(int id) async {
    try {
      final response = await userLocalDataSource.fetch(id);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> delete(int userId) async {
    try {
      final response = await userLocalDataSource.delete(userId);
      if (response == 0) {
        throw CacheFailure();
      }
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> fetchCurrent() async {
    try {
      final response = await userLocalDataSource.fetchCurrent();
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }


}