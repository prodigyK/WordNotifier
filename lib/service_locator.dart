import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:word_notifier/future/data/datasources/local_settings_data_source.dart';
import 'package:word_notifier/future/data/datasources/local_settings_data_source_impl.dart';
import 'package:word_notifier/future/domain/repositories/local_settings_repository_impl.dart';
import 'package:word_notifier/future/domain/usecases/locale/get_locale.dart';

import 'future/domain/repositories/local_settings_repository.dart';
import 'future/domain/usecases/locale/update_locale.dart';

final sl = GetIt.instance;

Future<void> init() async {

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton<LocalSettingsDataSource>(() => LocalSettingsDataSourceImpl(prefs: sl()));
  sl.registerLazySingleton<LocalSettingsRepository>(() => LocalSettingsRepositoryImpl(localSettingsDataSource: sl()));

  sl.registerLazySingleton(() => GetLocaleCase(localSettingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateLocaleCase(localSettingsRepository: sl()));

}