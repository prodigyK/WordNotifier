import 'dart:io';
import 'dart:ui';

import 'package:word_notifier/future/domain/repositories/local_settings_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetLocaleCase {
  final LocalSettingsRepository localSettingsRepository;

  GetLocaleCase({required this.localSettingsRepository});

  String call() {
      var result = localSettingsRepository.getLocale();
      if (result.isEmpty) {
        final platformLocale = Platform.localeName.substring(0, 2);
        print('platform locale = $platformLocale');
        bool isSupported = AppLocalizations.delegate.isSupported(Locale(platformLocale));
        if(isSupported) {
          print('platform locale = $platformLocale is supported');
          result = platformLocale;
        } else {
          result = 'en';
        }
      }
      return result;
  }

}
