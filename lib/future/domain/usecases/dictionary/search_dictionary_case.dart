import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:word_notifier/core/error/failure.dart';
import 'package:word_notifier/future/domain/entities/dictionary_entity.dart';
import 'package:word_notifier/future/domain/repositories/dictionary/dictionary_local_repository.dart';
import 'package:word_notifier/future/domain/usecases/usecases.dart';

class SearchDictionaryCase extends UseCase<List<DictionaryEntity>, SearchParams> {
  final DictionaryLocalRepository repository;

  SearchDictionaryCase({required this.repository});

  @override
  Future<Either<Failure, List<DictionaryEntity>>> call(params) async {
    return await repository.search(params.query);
  }
}

class SearchParams extends Equatable {
  final String query;

  const SearchParams(this.query);

  @override
  List<Object> get props => [query];
}
