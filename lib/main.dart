import 'package:ari/ui/views/init.dart';
import 'package:ari/ui/views/splash.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'business_logic/routes/nested_root.dart';

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
