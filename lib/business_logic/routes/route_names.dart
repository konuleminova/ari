import 'package:ari/ui/views/home/home.dart';
import 'package:ari/ui/views/profile/profile.dart';
import 'package:ari/ui/views/search/search.dart';

const ROUTE_SEARCH = '/search';
const ROUTE_PROFILE = '/profile';

final routeNames = {
// default rout as '/' is necessary!
  '/': (context) => HomeView(),
  ROUTE_SEARCH: (context) => SearchView(),
  ROUTE_PROFILE: (context) => ProfileView(),
};
