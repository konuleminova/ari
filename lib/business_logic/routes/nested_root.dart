import 'package:ari/ui/provider/app_bar/app_bar_action.dart';
import 'package:ari/ui/provider/app_bar/app_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NestedNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigationKey;
  final String initialRoute;
  final Map<String, WidgetBuilder> routes;

  NestedNavigator({
    @required this.navigationKey,
    @required this.initialRoute,
    @required this.routes,
  });

  @override
  Widget build(BuildContext context) {
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
          print('NAVIGATION ${navigationKey.currentState.widget}');
          navigationKey.currentState.pop();
          return Future<bool>.value(false);
        }
        return Future<bool>.value(true);
      },
    );
  }
}
