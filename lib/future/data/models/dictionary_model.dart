import 'package:word_notifier/future/domain/entities/dictionary_entity.dart';

class DictionaryModel extends DictionaryEntity {
  DictionaryModel({
    required id,
    required word,
    required translation,
    required transcription,
    required direction,
  }) : super(
          id: id,
          word: word,
          translation: translation,
          transcription: transcription,
          direction: direction,
        );

  factory DictionaryModel.fromJson(Map<String, dynamic> json) {
    return DictionaryModel(
      id: json['id'],
      word: json['word'],
      translation: json['translation'],
      transcription: json['transcription'],
      direction: json['direction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'translation': translation,
      'transcription': transcription,
      'direction': direction,
    };
  }
}
