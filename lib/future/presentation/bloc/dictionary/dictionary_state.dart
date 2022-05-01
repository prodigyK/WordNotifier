part of 'dictionary_cubit.dart';

@immutable
abstract class DictionaryState extends Equatable {
  @override
  List<Object> get props => [];
}

class DictionaryInitial extends DictionaryState {}

class DictionaryLoading extends DictionaryState {}

class DictionaryLoaded extends DictionaryState {
  final List<DictionaryEntity> dict;

  DictionaryLoaded({required this.dict});

  @override
  List<Object> get props => [dict];
}

class DictionaryError extends DictionaryState {
  final String message;

  DictionaryError(this.message);

  @override
  List<Object> get props => [message];
}
