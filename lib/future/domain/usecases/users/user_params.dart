import 'package:equatable/equatable.dart';
import 'package:word_notifier/future/domain/entities/user_entity.dart';

class UserParams extends Equatable {
  final UserEntity user;

  const UserParams(this.user);

  @override
  List<Object> get props => [user];
}
