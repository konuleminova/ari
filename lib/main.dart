import 'package:ari/services/provider/provider.dart';
import 'package:ari/ui/provider/app_bar/app_bar_state.dart';
import 'package:ari/ui/provider/change_language/change_language_state.dart';
import 'package:ari/ui/views/splash.dart';
import 'package:ari/ui/views/status/widgets/countdown_timer.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/app_localization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    SpUtil.getInstance().then((value) {
      runApp(MyApp());
    });
  });
}

class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final changeLangStore = useChangeLangStore();
    useProviderRegistration(changeLangStore);
    registerAppBarStore();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        locale: Locale(changeLangStore.state.lang ?? "az"),
        supportedLocales: [
          Locale('az', ''),
          Locale('en', ''),
          Locale('ru', '')
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
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
