import 'package:ari/ui/views/splash.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/app_localization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        locale: Locale('en'),
        supportedLocales: [
          Locale('az', ''),
          Locale('en', ''),
          Locale('ru', '')
        ],
        localizationsDelegates: [
          ApplicationLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocaleLanguage in supportedLocales) {
            if (supportedLocaleLanguage.languageCode == locale.languageCode) {
              return supportedLocaleLanguage;
            }
          }
          return supportedLocales.first;
        },
        theme: ThemeData(
          fontFamily: 'Bitter-Light',
          accentColor: ThemeColor().greenColor,
          primarySwatch: Colors.green,
          cursorColor: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen());
  }
}
