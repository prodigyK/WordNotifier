import 'package:dartz/dartz.dart';
import 'package:word_notifier/core/error/failure.dart';
import 'package:word_notifier/future/domain/repositories/user_local_repository.dart';
import 'package:word_notifier/future/domain/usecases/usecases.dart';
import 'package:word_notifier/future/domain/usecases/users/user_params.dart';

class UpdateUserCase extends UseCase<int, UserParams> {
  final UserLocalRepository userLocalRepository;

  UpdateUserCase({required this.userLocalRepository});

  @override
  Future<Either<Failure, int>> call(UserParams params) async {
    return await userLocalRepository.update(params.user);
  }
}
