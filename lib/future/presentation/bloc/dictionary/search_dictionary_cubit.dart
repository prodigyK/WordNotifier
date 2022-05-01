import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:word_notifier/future/domain/entities/dictionary_entity.dart';
import 'package:word_notifier/future/domain/usecases/dictionary/search_dictionary_case.dart';

part 'search_dictionary_state.dart';

class SearchDictionaryCubit extends Cubit<SearchDictionaryState> {
  final SearchDictionaryCase searchDictionaryCase;

  SearchDictionaryCubit({required this.searchDictionaryCase}) : super(SearchDictionaryInitial());

  Future<List<DictionaryEntity>> search(String query) async {
    final result = await searchDictionaryCase(SearchParams(query));

    return result.fold((failure) => [], (result) => result);
  }
}
