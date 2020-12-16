import 'package:ari/localization/app_localization.dart';
import 'package:flutter/material.dart';

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['az', 'en', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // TODO: implement load
    AppLocalizations applicationLocalizations =
        new AppLocalizations(locale);
    await applicationLocalizations.load();
    return applicationLocalizations;
  }

  @override
  bool shouldReload(
      covariant LocalizationsDelegate<AppLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }
}
