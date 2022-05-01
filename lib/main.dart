import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_notifier/common/navigation/navigation_service.dart';
import 'package:word_notifier/common/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:word_notifier/future/domain/usecases/locale/update_locale.dart';
import 'package:word_notifier/future/domain/usecases/users/fetch_user_case.dart';
import 'package:word_notifier/future/domain/usecases/users/insert_user_case.dart';
import 'package:word_notifier/service_locator.dart' as di;
import 'package:dotenv/dotenv.dart' as dotenv;

import 'common/themes/app_theme.dart';
import 'future/domain/usecases/dictionary/insert_dictionary_case.dart';
import 'future/domain/usecases/dictionary/search_dictionary_case.dart';
import 'future/domain/usecases/locale/get_locale.dart';
import 'future/presentation/bloc/dictionary/dictionary_cubit.dart';
import 'future/presentation/bloc/dictionary/search_dictionary_cubit.dart';
import 'future/presentation/bloc/locale/app_locale_cubit.dart';
import 'future/presentation/bloc/users/user_cubit.dart';
import 'future/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dotenv.load();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppLocaleCubit>(
          create: (context) => AppLocaleCubit(
            getLocaleCase: di.sl<GetLocaleCase>(),
            updateLocaleCase: di.sl<UpdateLocaleCase>(),
          )..getLocale(),
        ),
        BlocProvider<UserCubit>(
          lazy: false,
          create: (context) => UserCubit(
            insertUserCase: di.sl<InsertUserCase>(),
            fetchUserCase: di.sl<FetchUserCase>(),
          )..init(),
        ),
        BlocProvider<DictionaryCubit>(
          lazy: false,
          create: (context) => DictionaryCubit(
            insertDictionaryCase: di.sl<InsertDictionaryCase>(),
          ),
        ),
        BlocProvider<SearchDictionaryCubit>(
          lazy: false,
          create: (context) => SearchDictionaryCubit(
            searchDictionaryCase: di.sl<SearchDictionaryCase>(),
          ),
        ),
      ],
      child: WordNotifierApp(),
    ),
  );
}

class WordNotifierApp extends StatelessWidget {
  const WordNotifierApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLocaleCubit, AppLocaleState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: kDebugMode,
          initialRoute: HomeScreen.routeName,
          theme: AppTheme.themeData,
          routes: AppRoutes.routes,
          navigatorKey: NavigationService.navigatorKey,
          locale: state.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
