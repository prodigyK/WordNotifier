import 'package:word_notifier/future/data/models/card_model.dart';

abstract class CardLocalDataSource {
  Future<int> insert(CardModel card, int userId);

  Future<List<CardModel>> fetchAll(int userId);

  Future<int> update(CardModel card, int userId);

  Future<int> delete(CardModel card, int userId);
}