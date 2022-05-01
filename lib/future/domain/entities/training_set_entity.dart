import 'package:word_notifier/future/domain/entities/base_entity.dart';

class TrainingSetEntity extends BaseEntity {
  final int userId;
  final int trainingId;
  final int cardId;
  final bool isLearnt;

  const TrainingSetEntity({
    required id,
    required this.userId,
    required this.trainingId,
    required this.cardId,
    required this.isLearnt,
  }) : super(id);

  @override
  List<Object?> get props => [id, userId, trainingId, cardId, isLearnt];
}
