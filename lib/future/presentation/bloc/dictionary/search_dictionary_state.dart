part of 'search_dictionary_cubit.dart';

@immutable
abstract class SearchDictionaryState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchDictionaryInitial extends SearchDictionaryState {}

class SearchDictionaryLoading extends SearchDictionaryState {}

class SearchDictionaryLoaded extends SearchDictionaryState {
  final List<DictionaryEntity> dict;

  SearchDictionaryLoaded({required this.dict});

  @override
  List<Object> get props => [dict];
}

class SearchDictionaryError extends SearchDictionaryState {
  final String message;

  SearchDictionaryError(this.message);

  @override
  List<Object> get props => [message];
}
