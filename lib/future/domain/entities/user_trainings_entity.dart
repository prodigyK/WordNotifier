import 'base_entity.dart';

class UserTrainingsEntity extends BaseEntity {
  final int userId;
  final int trainingId;
  final bool isEnabled;

  const UserTrainingsEntity({
    required id,
    required this.userId,
    required this.trainingId,
    required this.isEnabled,
  }) : super(id);

  @override
  List<Object?> get props => [id, userId, trainingId, isEnabled];
}
