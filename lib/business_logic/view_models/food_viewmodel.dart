import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/services/services/food_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/food/food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FoodViewModel extends HookWidget {
  RouteArguments<Restourant> arguments;
  var verticalScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();
  @override
  Widget build(BuildContext context) {
    var maxExtent = useState<double>(0.0);
    useEffect(() {
      itemPositionsListener.itemPositions.addListener(() {
        maxExtent.value = itemPositionsListener
            ?.itemPositions?.value?.first?.index
            .toDouble();
      });
      return () {};
    }, [itemPositionsListener]);
    arguments = ModalRoute.of(context).settings.arguments;
    // TODO: implement build

    ApiResponse<List<GroupFood>> apiResponse = useFetchFoods(arguments.data.id);
    useSideEffect(() {
      return () {};
    }, [apiResponse]);

    return CustomErrorHandler(
        statuses: [
          apiResponse.status,
        ],
        errors: [
          apiResponse.error
        ],
        child: FoodView(
          maxExtentValue: maxExtent.value,
          foodList: apiResponse.data,
          itemPositionsListener: itemPositionsListener,
          verticalScrollController: verticalScrollController,
        ));
  }
}
