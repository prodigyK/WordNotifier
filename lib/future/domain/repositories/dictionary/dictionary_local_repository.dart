import 'package:dartz/dartz.dart';
import 'package:word_notifier/core/error/failure.dart';
import 'package:word_notifier/future/domain/entities/dictionary_entity.dart';

abstract class DictionaryLocalRepository {
  Future<Either<Failure, int>> insert(DictionaryEntity dict);

  Future<Either<Failure, List<DictionaryEntity>>> search(String query);
}