import 'package:ari/localization/app_localization.dart';
import 'package:flutter/material.dart';

class AppLocalizationsDelegate
    extends LocalizationsDelegate<ApplicationLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['az', 'en', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<ApplicationLocalizations> load(Locale locale) async {
    // TODO: implement load
    ApplicationLocalizations applicationLocalizations =
        new ApplicationLocalizations(locale);
    await applicationLocalizations.load();
    return applicationLocalizations;
  }

  @override
  bool shouldReload(
      covariant LocalizationsDelegate<ApplicationLocalizations> old) {
    // TODO: implement shouldReload
    return false;
  }
}
