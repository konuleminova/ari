import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/services/services/food_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/food/food.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FoodViewModel extends HookWidget {
  RouteArguments<Restourant> arguments;
  var verticalScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    var maxScrollExtent = useState<double>(0.0);
    var foodState = useState<Food>();
    var apiResponseData = useState<List<GroupFood>>();
    arguments = ModalRoute.of(context).settings.arguments;

    //Vertical Scrolling hide sliver Appbar
    useEffect(() {
      itemPositionsListener.itemPositions.addListener(() {
        var isElement = itemPositionsListener.itemPositions.value
            .firstWhere((element) => element != null, orElse: () => null);
        if (isElement != null) {
          maxScrollExtent.value = itemPositionsListener
                  ?.itemPositions?.value.first.itemLeadingEdge
                  .toDouble() -
              itemPositionsListener?.itemPositions?.value.first.index
                  .toDouble();
        }
      });
      return () {};
    }, [itemPositionsListener]);

    //use Fetch food products
    ApiResponse<List<GroupFood>> apiResponse = useFetchFoods(arguments.data.id);
    useSideEffect(() {
      if (apiResponse.status == Status.Done) {
        apiResponseData.value = apiResponse.data;
      }
      return () {};
    }, [apiResponse, apiResponseData.value]);

    //Add to cart callBack

    final addToCartCallBack = useCallback((Food food) {
      foodState.value = food;
      if (apiResponse.status == Status.Done) {
        apiResponseData.value.forEach((element) {
          element.foods.forEach((element) {
            if (element.id == food.id) {
              element.selected = food.selected;
            }
          });
        });
        apiResponseData.notifyListeners();
      }
    }, [foodState.value]);
    return CustomErrorHandler(
        statuses: [
          apiResponse.status,
        ],
        errors: [
          apiResponse.error
        ],
        child: FoodView(
          maxExtentValue: maxScrollExtent.value,
          foodList: apiResponseData.value,
          itemPositionsListener: itemPositionsListener,
          verticalScrollController: verticalScrollController,
          addtoCartCallback: addToCartCallBack,
        ));
  }
}
