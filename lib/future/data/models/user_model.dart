import 'package:word_notifier/future/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required id,
    required name,
    required email,
    required password,
    required createdAt,
    isDisabled = false,
  }) : super(
          id: id,
          name: name,
          email: email,
          password: password,
          createdAt: createdAt,
          isDisabled: isDisabled,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      isDisabled: json['is_disabled'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'created_at': createdAt.millisecondsSinceEpoch,
      'is_disabled': isDisabled ? 1 : 0,
    };
  }
}
