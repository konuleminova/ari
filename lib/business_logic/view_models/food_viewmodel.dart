import 'package:ari/business_logic/models/food.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/services/services/food_service.dart';
import 'package:ari/ui/views/restaurant/restaurant.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FoodViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ApiResponse<List<Food>> apiResponse = useFetchFoods('8');
    useSideEffect(() {
      return () {};
    }, [apiResponse]);

    return RestaurantView(apiResponse: apiResponse,);
  }
}
