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

  factory UserEntity.empty() {
    return UserEntity(
      id: 0,
      name: '',
      email: '',
      password: '',
      createdAt: DateTime.now(),
    );
  }

  factory UserEntity.defaultUser() {
    return UserEntity(
      id: 0,
      name: 'default',
      email: 'test@email.com',
      password: '123',
      createdAt: DateTime.now(),
    );
  }

  @override
  List<Object> get props => [id, name, email, password, createdAt, isDisabled];

  @override
  String toString() {
    return 'UserEntity{name: $name, email: $email, password: $password, createdAt: $createdAt, isDisabled: $isDisabled}';
  }
}
