import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:word_notifier/core/error/failure.dart';
import 'package:word_notifier/future/domain/entities/user_entity.dart';
import 'package:word_notifier/future/domain/usecases/users/fetch_user_case.dart';
import 'package:word_notifier/future/domain/usecases/users/insert_user_case.dart';
import 'package:word_notifier/future/domain/usecases/users/user_params.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final InsertUserCase insertUserCase;
  final FetchUserCase fetchUserCase;
  UserEntity? user;

  UserCubit({
    required this.insertUserCase,
    required this.fetchUserCase,
  }) : super(UserInitialState());

  void init() async {
    UserEntity emptyUser = UserEntity.empty();
    final result = await fetchUserCase(UserParams(emptyUser));
    await result.fold(
      (failure) {
        debugPrint('user = ${_getErrorMessage(failure)}');
      },
      (value) async {
        user = value;
        debugPrint('user = $value');
        if (user == null) {
          UserEntity newUser = UserEntity.defaultUser();
          Either<Failure, int> newResult = await insertUserCase(UserParams(newUser));
          newResult.fold((failure) {
            debugPrint('new user = ${_getErrorMessage(failure)}');
          }, (newValue) {
            user = value;
            debugPrint('new user = $newValue');
          });
        }
      },
    );
  }

  void insert(UserEntity user) async {
    emit(UserLoadingState());

    Either<Failure, int> result = await insertUserCase(UserParams(user));
    result.fold(
      (failure) => emit(UserErrorState(_getErrorMessage(failure))),
      (value) => emit(UserNumberLoadedState(value)),
    );
  }

  void fetchUser() async {}

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
