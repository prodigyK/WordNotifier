import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:word_notifier/core/error/failure.dart';
import 'package:word_notifier/future/domain/entities/dictionary_entity.dart';
import 'package:word_notifier/future/domain/repositories/dictionary/dictionary_local_repository.dart';

import '../usecases.dart';

class InsertDictionaryCase extends UseCase<int, InsertParams> {
  final DictionaryLocalRepository repository;

  InsertDictionaryCase({required this.repository});

  @override
  Future<Either<Failure, int>> call(InsertParams params) async {
    return await repository.insert(params.entity);
  }
}

class InsertParams extends Equatable {
  final DictionaryEntity entity;

  const InsertParams({required this.entity});

  @override
  List<Object?> get props => [entity];
}
