import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'db_data.dart';

const String dictLoaded = 'DICT_LOADED';

class AppUtilsDB {
  AppUtilsDB._();

  static void loadDictionaryFromFile({required Database database, required SharedPreferences prefs}) async {
    bool isLoaded = false;
    if (prefs.containsKey(dictLoaded)) {
      isLoaded = prefs.getBool(dictLoaded) ?? false;
    }
    if (isLoaded) {
      return;
    }
    int start = DateTime.now().millisecondsSinceEpoch;
    List<Map<String, String>> dict = await _parseDictionaryFile();

    database.transaction((txn) async {
      for (var element in dict) {
        await txn.insert(
          AppDatabaseSettings.dictionaryTable,
          element,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
    List<dynamic> result = await database.rawQuery(
      'SELECT * FROM ${AppDatabaseSettings.dictionaryTable}',
    );

    if (result.length > 1000) {
      prefs.setBool(dictLoaded, true);
    }

    int end = DateTime.now().millisecondsSinceEpoch;
    debugPrint('time = ${(end - start) / 1000}, ${result.length}');
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
