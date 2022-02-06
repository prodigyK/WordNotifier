import 'dart:ui';

import 'package:word_notifier/future/domain/repositories/local_settings_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateLocaleCase {
  final LocalSettingsRepository localSettingsRepository;

  UpdateLocaleCase({required this.localSettingsRepository});

  Future<bool> call(Locale locale) async {
    final updatedLocale = await AppLocalizations.delegate.load(locale);
    return await localSettingsRepository.setLocale(updatedLocale.localeName);
  }
}