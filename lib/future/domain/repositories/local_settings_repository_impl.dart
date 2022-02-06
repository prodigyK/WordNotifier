import 'package:word_notifier/future/data/datasources/local_settings_data_source.dart';
import 'package:word_notifier/future/domain/repositories/local_settings_repository.dart';

class LocalSettingsRepositoryImpl implements LocalSettingsRepository {
  final LocalSettingsDataSource localSettingsDataSource;

  LocalSettingsRepositoryImpl({required this.localSettingsDataSource});

  @override
  String getLocale() {
    return localSettingsDataSource.getLocale();
  }

  @override
  Future<bool> setLocale(String languageCode) {
    return localSettingsDataSource.setLocale(languageCode);
  }

}