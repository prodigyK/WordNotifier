import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_notifier/common/navigation/navigation_service.dart';
import 'package:word_notifier/common/routes/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:word_notifier/future/domain/usecases/locale/update_locale.dart';
import 'package:word_notifier/service_locator.dart' as di;

import 'common/themes/app_theme.dart';
import 'future/domain/usecases/locale/get_locale.dart';
import 'future/presentation/bloc/locale/app_locale_cubit.dart';
import 'future/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      ],
      child: WordNotifierApp(),
    ),
  );
}

class WordNotifierApp extends StatelessWidget {
  WordNotifierApp({Key? key}) : super(key: key);

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
