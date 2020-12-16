import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_localization_delegate.dart';

class AppLocalizations {
  final Locale appLocale;

  AppLocalizations(this.appLocale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(
        context, AppLocalizations);
  }

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString = await rootBundle
        .loadString('assets/locales/${appLocale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    return true;
  }

  String translate(String jsonKey) {
    return _localizedStrings[jsonKey];
  }

  static const LocalizationsDelegate delegate = AppLocalizationsDelegate();
}
