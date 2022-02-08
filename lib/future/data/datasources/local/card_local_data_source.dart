import 'package:word_notifier/future/data/models/card_model.dart';

abstract class CardLocalDataSource {
  Future<int> insert(CardModel user);

  Future<CardModel> fetch(int id);

  Future<int> update(CardModel user);

  Future<int> delete(int userId);
}