import 'package:word_notifier/future/domain/entities/card_entity.dart';

class CardModel extends CardEntity {
  const CardModel({
    required id,
    required word,
    required translation,
    required isLearnt,
    required createdAt,
    required userId,
  }) : super(
          id: id,
          word: word,
          translation: translation,
          isLearnt: isLearnt,
          createdAt: createdAt,
          userId: userId,
        );

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'],
      word: json['word'],
      translation: json['translation'],
      isLearnt: json['is_learnt'] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] as int),
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'translation': translation,
      'is_learnt': isLearnt ? 1 : 0,
      'created_at': createdAt.millisecondsSinceEpoch,
      'user_id': userId,
    };
  }
}
