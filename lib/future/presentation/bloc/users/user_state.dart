part of 'user_cubit.dart';

@immutable
abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final UserEntity user;

  UserLoadedState(this.user);

  @override
  List<Object> get props => [user];
}

class UserNumberLoadedState extends UserState {
  final int result;

  UserNumberLoadedState(this.result);

  @override
  List<Object> get props => [result];
}

class UserErrorState extends UserState {
  final String message;

  UserErrorState(this.message);

  @override
  List<Object> get props => [message];
}
