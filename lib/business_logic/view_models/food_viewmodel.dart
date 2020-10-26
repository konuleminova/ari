import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/services/services/food_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/food/food.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FoodViewModel extends HookWidget {
  RouteArguments<Restourant> arguments;
  @override
  Widget build(BuildContext context) {
    arguments=ModalRoute.of(context).settings.arguments;
    // TODO: implement build

    ApiResponse<List<Food>> apiResponse = useFetchFoods(arguments.data.id);
    useSideEffect(() {
      return () {};
    }, [apiResponse]);

    return CustomErrorHandler(
      statuses: [apiResponse.status,],
      errors: [apiResponse.error],
      child: FoodView(
        foodList: apiResponse.data,
      ),
    );
  }
}
