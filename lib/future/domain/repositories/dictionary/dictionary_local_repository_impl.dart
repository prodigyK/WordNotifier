import 'package:dartz/dartz.dart';
import 'package:word_notifier/core/error/exception.dart';
import 'package:word_notifier/core/error/failure.dart';
import 'package:word_notifier/future/data/datasources/local/dictionary/dictionary_local_data_source.dart';
import 'package:word_notifier/future/data/models/dictionary_model.dart';
import 'package:word_notifier/future/domain/entities/dictionary_entity.dart';
import 'package:word_notifier/future/domain/repositories/dictionary/dictionary_local_repository.dart';

class DictionaryLocalRepositoryImpl implements DictionaryLocalRepository {
  final DictionaryLocalDataSource dataSource;

  DictionaryLocalRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, int>> insert(DictionaryEntity dict) async {
    try {
      final response = await dataSource.insert(
        DictionaryModel(
          id: dict.id,
          word: dict.word,
          translation: dict.translation,
          transcription: dict.transcription,
          direction: dict.direction,
        ),
      );
      if (response <= 0) {
        throw CacheFailure();
      }
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<DictionaryEntity>>> search(String query) async {
    try {
      final response = await dataSource.search(query);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
