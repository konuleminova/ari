import 'package:ari/business_logic/view_models/product_viewmodel.dart';
import 'package:ari/ui/home.dart';
import 'package:ari/ui/provider_components/component_a.dart';
import 'package:ari/ui/views/home/home.dart';
import 'package:ari/ui/views/init/init.dart';
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
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: InitPage()
    );
  }
}
