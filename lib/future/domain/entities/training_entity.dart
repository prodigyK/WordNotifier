import 'base_entity.dart';

class TrainingEntity extends BaseEntity {
  final String name;

  const TrainingEntity({
    required id,
    required this.name,
  }) : super(id);

  @override
  List<Object?> get props => [id, name];
}
