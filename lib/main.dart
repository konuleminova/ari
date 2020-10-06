import 'package:ari/services/service_localator.dart';
import 'package:ari/ui/views/home/home.dart';
import 'package:flutter/material.dart';
void main() {
  setUpServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage());
  }
}
