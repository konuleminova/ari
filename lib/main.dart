import 'package:ari/ui/views/init.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';

import 'business_logic/routes/nested_root.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Bitter-Light',
          accentColor: ThemeColor().greenColor,
          primarySwatch:Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: InitPage()
    );
  }
}
