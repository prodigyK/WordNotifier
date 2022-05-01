import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:word_notifier/core/error/failure.dart';
import 'package:word_notifier/future/domain/entities/dictionary_entity.dart';
import 'package:word_notifier/future/domain/usecases/dictionary/insert_dictionary_case.dart';

part 'dictionary_state.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  final InsertDictionaryCase insertDictionaryCase;

  DictionaryCubit({required this.insertDictionaryCase}) : super(DictionaryInitial());

  void insertTranslation(DictionaryEntity entity) async {
    final result = await insertDictionaryCase(InsertParams(entity: entity));
    // result.fold((failure) => _getErrorMessage(failure), (result) => result);
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unknown Failure';
    }
  }
}
