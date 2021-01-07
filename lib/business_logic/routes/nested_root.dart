import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/ui/provider/app_bar/app_bar_action.dart';
import 'package:ari/ui/provider/app_bar/app_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NestedNavigator extends HookWidget {
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
    var name = useState<String>();
    return WillPopScope(
      child: Navigator(
        key: navigationKey,
        initialRoute: initialRoute,
        onGenerateRoute: (RouteSettings routeSettings) {
          name.value = routeSettings.name;
          WidgetBuilder builder = routes[routeSettings.name];
          print("CHNAGE ROUTE ${routeSettings.name}");
          if (routeSettings.name == ROUTE_SEARCH ||
              routeSettings.name == ROUTE_PROFILE ||
              routeSettings.name == ROUTE_RESTAURANT) {
          } else {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => getAppBarStore().dispatch(AppBarAction(index: 0)));
          }
          return MaterialPageRoute(
            builder: builder,
            settings: routeSettings,
          );
        },
      ),
      onWillPop: () {
        print('NAMEX ${name.value} ${ROUTE_STATUS}');
        if (name.value == ROUTE_STATUS) {
          pushRouteWithName('/');
          return Future<bool>.value(false);
        }
        if (navigationKey.currentState.canPop()) {
          navigationKey.currentState.pop();
          return Future<bool>.value(false);
        }

        return Future<bool>.value(true);
      },
    );
  }
}
