import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:word_notifier/future/data/datasources/local/card_local_data_source.dart';
import 'package:word_notifier/future/data/datasources/local/card_local_data_source_impl.dart';
import 'package:word_notifier/future/data/datasources/local/dictionary/dictionary_local_data_source.dart';
import 'package:word_notifier/future/data/datasources/local_settings_data_source.dart';
import 'package:word_notifier/future/data/datasources/local_settings_data_source_impl.dart';
import 'package:word_notifier/future/data/datasources/local/user_local_data_source.dart';
import 'package:word_notifier/future/data/datasources/local/user_local_data_source_impl.dart';
import 'package:word_notifier/future/domain/repositories/local_settings_repository_impl.dart';
import 'package:word_notifier/future/domain/repositories/user_local_repository_impl.dart';
import 'package:word_notifier/future/domain/usecases/locale/get_locale.dart';
import 'package:word_notifier/future/domain/usecases/users/fetch_user_case.dart';
import 'package:word_notifier/future/domain/usecases/users/insert_user_case.dart';

import 'core/db/db_data.dart';
import 'future/data/datasources/local/dictionary/dictionary_local_data_source_impl.dart';
import 'future/domain/repositories/local_settings_repository.dart';
import 'future/domain/repositories/user_local_repository.dart';
import 'future/domain/usecases/locale/update_locale.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Localization
  sl.registerLazySingleton<LocalSettingsDataSource>(() => LocalSettingsDataSourceImpl(prefs: sl()));
  sl.registerLazySingleton<LocalSettingsRepository>(() => LocalSettingsRepositoryImpl(localSettingsDataSource: sl()));
  sl.registerLazySingleton(() => GetLocaleCase(localSettingsRepository: sl()));
  sl.registerLazySingleton(() => UpdateLocaleCase(localSettingsRepository: sl()));

  // Create a card database
  final Database database = await AppDatabaseSettings.openDB();
  sl.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImpl(database: database));
  sl.registerLazySingleton<CardLocalDataSource>(() => CardLocalDataSourceImpl(database: database));

  // Users objects
  sl.registerLazySingleton<UserLocalRepository>(() => UserLocalRepositoryImpl(userLocalDataSource: sl()));
  sl.registerLazySingleton<InsertUserCase>(() => InsertUserCase(userLocalRepository: sl()));
  sl.registerLazySingleton<FetchUserCase>(() => FetchUserCase(userLocalRepository: sl()));

  // Create a dictionary database
  final Database databaseDict = await AppDatabaseSettings.openDictionaryDB();
  sl.registerLazySingleton<DictionaryLocalDataSource>(() => DictionaryLocalDataSourceImpl(database: databaseDict));
}

