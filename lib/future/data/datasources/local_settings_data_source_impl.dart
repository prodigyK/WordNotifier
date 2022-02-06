
import 'package:flutter/cupertino.dart';
import 'package:word_notifier/future/data/datasources/local_settings_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSettingsDataSourceImpl implements LocalSettingsDataSource {
  static const String localeString = 'LOCALE_STRING';
  final SharedPreferences prefs;

  LocalSettingsDataSourceImpl({required this.prefs});

  @override
  String getLocale() {
    try {
      return prefs.getString(localeString) ?? '';
    } catch (error) {
      debugPrint('locale is absent in local store: $error');
      return '';
    }
  }

  @override
  Future<bool> setLocale(String languageCode) async {
    return await prefs.setString(localeString, languageCode);
  }

}