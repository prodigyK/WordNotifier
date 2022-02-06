import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import 'package:word_notifier/future/domain/usecases/locale/get_locale.dart';
import 'package:word_notifier/future/domain/usecases/locale/update_locale.dart';

part 'app_locale_state.dart';

class AppLocaleCubit extends Cubit<AppLocaleState> {
  final GetLocaleCase getLocaleCase;
  final UpdateLocaleCase updateLocaleCase;

  AppLocaleCubit({
    required this.getLocaleCase,
    required this.updateLocaleCase,
  }) : super(const AppLocaleState());

  void updateLocale(Locale locale) async {
    await updateLocaleCase(locale);

    emit(AppLocaleState(locale));
  }

  Locale getLocale() {
    final locale = Locale(getLocaleCase());

    emit(AppLocaleState(locale));
    return locale;
  }
}
