import 'package:dartz/dartz.dart';
import 'package:word_notifier/core/error/failure.dart';

abstract class UserRemoteRepository {
  Future<Either<Failure, String>> generateUniqueIdentifier();
}