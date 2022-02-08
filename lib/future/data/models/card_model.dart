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
}
