import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'db_data.dart';

const String dictLoaded = 'DICT_LOADED';

class AppUtilsDB {
  AppUtilsDB._();

  /// Load dictionary from file and insert it to database
  static void loadDictionaryFromFile({required Database database, required SharedPreferences prefs}) async {
    bool isLoaded = false;

    // check if db version is changed, if yes reload data
    if (prefs.containsKey(dictLoaded)) {
      isLoaded = prefs.getInt(dictLoaded) == AppDatabaseSettings.versionDictDb;
    }
    if (isLoaded) {
      return;
    }
    int start = DateTime.now().millisecondsSinceEpoch;

    // load and parse data from file
    List<Map<String, String>> dict = await _parseDictionaryFile();

    // delete all rows
    int rows = await database.delete(AppDatabaseSettings.dictionaryTable);
    debugPrint('Rows deleted = $rows');

    // insert rows
    await database.transaction((txn) async {
      for (var element in dict) {
        await txn.insert(
          AppDatabaseSettings.dictionaryTable,
          element,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });

    // check success
    List<dynamic> result = await database.rawQuery(
      'SELECT count(*) FROM ${AppDatabaseSettings.dictionaryTable}',
    );
    if (result[0].row.first > 9000) {
      prefs.setInt(dictLoaded, AppDatabaseSettings.versionDictDb);
    }

    int end = DateTime.now().millisecondsSinceEpoch;
    debugPrint('time = ${(end - start) / 1000}, ${result[0].row.first}');
  }

  static Future<List<Map<String, String>>> _parseDictionaryFile() async {
    String fileContent = await rootBundle.loadString('assets/dict/dict_9000.txt');

    List<Map<String, String>> dict = [];
    List<String> fileList = fileContent.split('\r\n');
    for (var line in fileList) {
      if (line.trim().isEmpty) {
        continue;
      }

      line = line.trim().replaceAll(RegExp(r'^[0-9]+ *'), '');
      List<String> parts = line.trim().split(RegExp(r'\[[^\]]*\]'));
      String? transcription = RegExp(r'\[[^\]]*\]').stringMatch(line);
      if (parts.length == 2) {
        dict.add({
          'word': parts[0].trim(),
          'translation': parts[1].trim(),
          'transcription': transcription ?? '',
          'direction': 'EN-RU',
        });
      }
    }
    return dict;
  }
}
