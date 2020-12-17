import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NestedNavigator extends HookWidget {
  final GlobalKey<NavigatorState> navigationKey;
  final String initialRoute;
  final Map<String, WidgetBuilder> routes;

  NestedNavigator(
      {@required this.navigationKey,
      @required this.initialRoute,
      @required this.routes,});

  @override
  Widget build(BuildContext context) {
    print('IN NAVIGATOR STORE ');


    return WillPopScope(
      child: Navigator(
        key: navigationKey,
        initialRoute: initialRoute,
        onGenerateRoute: (RouteSettings routeSettings) {
          WidgetBuilder builder = routes[routeSettings.name];
          return MaterialPageRoute(
            builder: builder,
            settings: routeSettings,
          );
        },
      ),
      onWillPop: () {
        if (navigationKey.currentState.canPop()) {
          navigationKey.currentState.pop();
          return Future<bool>.value(false);
        }
        return Future<bool>.value(true);
      },
    );
  }
}
