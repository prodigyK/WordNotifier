part of 'app_locale_cubit.dart';

class AppLocaleState extends Equatable {
  final Locale locale;

  const AppLocaleState([this.locale = const Locale('ru')]);

  @override
  List<Object> get props => [locale];
}

