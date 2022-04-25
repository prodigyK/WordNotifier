import 'package:dartz/dartz.dart';
import 'package:word_notifier/core/error/failure.dart';
import 'package:word_notifier/future/domain/entities/user_entity.dart';

abstract class UserLocalRepository {
  Future<Either<Failure, int>> insert(UserEntity user);

  Future<Either<Failure, UserEntity>> fetch(int id);

  Future<Either<Failure, UserEntity?>> fetchCurrent();

  Future<Either<Failure, int>> update(UserEntity user);

  Future<Either<Failure, int>> delete(int userId);
}