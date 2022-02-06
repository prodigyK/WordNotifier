
abstract class LocalSettingsRepository {
  String getLocale();

  Future<bool> setLocale(String languageCode);
}