import 'package:dartz/dartz.dart';
import 'package:word_notifier/core/error/failure.dart';
import 'package:word_notifier/future/domain/entities/user_entity.dart';
import 'package:word_notifier/future/domain/repositories/user_local_repository.dart';
import 'package:word_notifier/future/domain/usecases/users/user_params.dart';

import '../usecases.dart';

class FetchUserCase extends UseCase<UserEntity, UserParams> {
  final UserLocalRepository userLocalRepository;

  FetchUserCase({required this.userLocalRepository});

  @override
  Future<Either<Failure, UserEntity?>> call(UserParams params) async {
    return await userLocalRepository.fetchCurrent();
  }
}
