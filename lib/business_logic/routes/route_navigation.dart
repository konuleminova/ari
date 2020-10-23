import 'package:ari/ui/views/init.dart';

void pushRouteWithName(String name, {RouteArguments arguments}) {
  navigationKey.currentState.pushNamed(name, arguments: arguments);
}

class RouteArguments<T> {
  T data;

  RouteArguments({this.data});
}
