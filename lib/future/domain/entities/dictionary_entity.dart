import 'package:word_notifier/future/domain/entities/base_entity.dart';

class DictionaryEntity extends BaseEntity {
  final String word;
  final String translation;
  final String transcription;
  final String direction;

  DictionaryEntity({
    required id,
    required this.word,
    required this.translation,
    required this.transcription,
    required this.direction,
  }) : super(id);

  @override
  List<Object> get props => [id, word, translation, transcription, direction];
}
