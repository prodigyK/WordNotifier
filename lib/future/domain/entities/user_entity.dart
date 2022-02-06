import 'package:word_notifier/future/domain/entities/base_entity.dart';

class UserEntity extends BaseEntity {
  final String name;
  final String email;
  final String password;
  final DateTime createdAt;
  final bool isDisabled;

  const UserEntity({
    required id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
    this.isDisabled = false,
  }) : super(id);

  @override
  List<Object> get props => [id, name, email, password, createdAt, isDisabled];
}
