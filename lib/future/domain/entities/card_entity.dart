import 'base_entity.dart';

class CardEntity extends BaseEntity {
  final String word;
  final String translation;
  final bool isLearnt;
  final DateTime createdAt;
  final int userId;

  const CardEntity({
    required id,
    required this.word,
    required this.translation,
    required this.isLearnt,
    required this.createdAt,
    required this.userId,
  }) : super(id);

  CardEntity copyWith({
    int? id,
    String? word,
    String? translation,
    bool? isLearnt,
    DateTime? createdAt,
    int? userId,
  }) {
    return CardEntity(
      id: id ?? this.id,
      word: word ?? this.word,
      translation: translation ?? this.translation,
      isLearnt: isLearnt ?? this.isLearnt,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object> get props => [id, word, translation, isLearnt, createdAt, userId];
}
