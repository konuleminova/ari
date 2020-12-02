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
    var atLeastOneItemSelected = useState<bool>(false);
    var maxScrollExtent = useState<double>(0.0);
    var foodState = useState<Food>();
    var apiResponseData = useState<List<GroupFood>>();
    ValueNotifier<List<GroupFood>> addedFoodList =
        useState<List<GroupFood>>([]);
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
      addedFoodList.value = [];
      atLeastOneItemSelected.value = false;
      if (apiResponse.status == Status.Done) {
        apiResponseData.value.forEach((element) {
          element.foods.forEach((element) {
            if (element.id == food.id) {
              element.selected = food.selected;
            }
          });
        });
        apiResponseData.notifyListeners();

        //Add items Status Calculation
        apiResponseData.value.forEach((element) {
          if ((element.foods.firstWhere((it) => it.selected == true,
                  orElse: () => null)) !=
              null) {
            atLeastOneItemSelected.value = true;
          }
          //get Total Price formula
          apiResponse.data.forEach((element1) {
            element1.foods.forEach((element2) {
              element2.totalPrice = 0;
              element2.totalPrice = element2.totalPrice +
                  element2.count * double.parse(element2.price);
              for (int i = 0; i < element2.adds.length; i++) {
                if (element2.adds[i].type == 2) {
                  element2.addsType2.add(element2.adds[i]);
                } else {
                  element2.totalPrice = element2.totalPrice +
                      element2.adds[i].count *
                          double.parse(element2.adds[i].price);
                }
              }
              if (element2.addsType2.length > 0) {
                for (int i = 0; i < element2.addsType2.length; i++) {
                  if (i == 0) {
                    element2.totalPrice = element2.totalPrice +
                        element2.addsType2[0].count *
                            double.parse(element2.addsType2[0].price);
                  }
                }
              }
            });
          });
        });
      }
    }, [foodState.value, apiResponseData.value]);

    //Go to payment callback

    final goToPaymentCallBack = useCallback(() {

      addedFoodList.value.clear();
      print('HERE GROUP LIST');
      //Final selected items add to bag
     apiResponseData.value.forEach((element) {
        element.foods.forEach((element1) {
          if (element1.selected) {
//            if (element1.adds.length > 0) {
//              element1.adds.forEach((element3) {
//                if (element3.selected) {
//                  if (element3.type != 2) {
//                    element1.adds.add(element3);
//                  }
//                }
//              });
//              if (element1.addsType2.length > 0) {
//                if (element1.addsType2[0].selected) {
//                  element1.adds.add(element1.addsType2[0]);
//                }
//              }
//            }
            addedFoodList.value
                .add(GroupFood(foods: List<Food>()..add(element1)));
          }
        });
      });
     // addedFoodList.value=groupFoods;
    },[]);

    final dropDownCallBack =useCallback((Food food){
      foodState.value=food;
    });

    return CustomErrorHandler(
        statuses: [
          apiResponse.status,
        ],
        errors: [
          apiResponse.error
        ],
        child: FoodView(
            goToPaymentCallBack:goToPaymentCallBack,
            addedFoodList: addedFoodList.value,
            maxExtentValue: maxScrollExtent.value,
            foodList: apiResponseData.value,
            dropDownCallBack:dropDownCallBack ,
            itemPositionsListener: itemPositionsListener,
            verticalScrollController: verticalScrollController,
            addtoCartCallback: addToCartCallBack,
            atLeastOneItemSelected: atLeastOneItemSelected.value));
  }
}
