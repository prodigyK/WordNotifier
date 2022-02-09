import 'package:word_notifier/future/data/models/dictionary_model.dart';

abstract class DictionaryLocalDataSource {
  Future<int> insert(DictionaryModel dict);

  Future<List<DictionaryModel>> search(String query);
}