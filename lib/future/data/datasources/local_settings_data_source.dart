
abstract class LocalSettingsDataSource {
  String getLocale();

  Future<bool> setLocale(String languageCode);
}