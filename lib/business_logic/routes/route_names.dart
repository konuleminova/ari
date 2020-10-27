import 'package:ari/business_logic/view_models/food_viewmodel.dart';
import 'package:ari/business_logic/view_models/restourant_viewmodel.dart';
import 'package:ari/business_logic/view_models/search_viewmodel.dart';
import 'package:ari/ui/views/profile/profile.dart';

const ROUTE_SEARCH = '/search';
const ROUTE_PROFILE = '/profile';
const ROUTE_RESTAURANT = '/restaurant';

final routeNames = {
// default rout as '/' is necessary!
  '/': (context) => RestourantViewModel(),
  ROUTE_SEARCH: (context) => SearchViewModel(),
  ROUTE_PROFILE: (context) => ProfileView(),
  ROUTE_RESTAURANT: (context) => FoodViewModel()
};

