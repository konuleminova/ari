import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/menu.dart';
import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/services/services/food_service.dart';
import 'package:ari/services/services/menu_service.dart';
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
    ValueNotifier<List<Food>> foods = useState<List<Food>>([]);
    arguments = ModalRoute.of(context).settings.arguments;
    var apiResponseMenu = useState<ApiResponse<List<Menu>>>();
    apiResponseMenu.value = useFetchMenu(arguments.data.id);

    //Vertical Scrolling hide sliver Appbar
    useEffect(() {
      itemPositionsListener.itemPositions.addListener(() {
        var isElement = itemPositionsListener.itemPositions.value
            .firstWhere((element) => element != null, orElse: () => null);
        if (isElement != null) {
          if (foods.value[0].expanded) {
            maxScrollExtent.value = -1;
          } else {
            maxScrollExtent.value = itemPositionsListener
                    ?.itemPositions?.value.first.itemLeadingEdge
                    .toDouble() -
                itemPositionsListener?.itemPositions?.value.first.index
                    .toDouble();
          }
        }
      });
      return () {};
    }, [itemPositionsListener]);

    //use Fetch food products
    ApiResponse<List<GroupFood>> apiResponse = useFetchFoods(arguments.data.id);
    useSideEffect(() {
      if (apiResponse.status == Status.Done) {
        foods.value.clear();
        apiResponse.data.forEach((element) {
          foods.value.addAll(element.foods);
        });
        apiResponseData.value = apiResponse.data;
        if (apiResponseMenu.value.status == Status.Done) {
          for (int j = 0; j < apiResponseMenu.value.data.length; j++) {
            for (int i = 0; i < foods.value.length; i++) {
              if (apiResponseMenu.value.data[j].id == foods.value[i].menu_id) {
                foods.value[i].groupName = apiResponseMenu.value.data[j].name;
                break;
              }
            }
            continue;
          }
        }
      }
      return () {};
    }, [apiResponse, apiResponseData.value, apiResponseMenu.value]);

    //Add to cart callBack
    final addToCartCallBack = useCallback((Food food) {
      if (arguments.data.working) {
        if (food.expanded) {
          maxScrollExtent.value = -1;
          verticalScrollController.jumpTo(
            index: foods.value.indexOf(food),
          );
        }
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

          //At least one  item selected Calculation
          apiResponseData.value.forEach((element) {
            if ((element.foods.firstWhere((it) => it.selected == true,
                    orElse: () => null)) !=
                null) {
              atLeastOneItemSelected.value = true;
            }

            //geet Total Price formula
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
      }else {
        atLeastOneItemSelected.value=true;
      }
    }, [foodState.value, apiResponseData.value]);

    //Go to payment callback
    final goToPaymentCallBack = useCallback(() {
      addedFoodList.value.clear();
      apiResponseData.value.forEach((element) {
        element.foods.forEach((element1) {
          if (element1.selected) {
            addedFoodList.value
                .add(GroupFood(foods: List<Food>()..add(element1)));
          }
        });
      });
    }, []);

    //DropDown select item callback
    final dropDownCallBack = useCallback((Food food) {
      foodState.value = food;
    });

    return CustomErrorHandler(
        statuses: [
          apiResponse.status,
        ],
        errors: [
          apiResponse.error
        ],
        child: FoodView(
            goToPaymentCallBack: goToPaymentCallBack,
            addedFoodList: addedFoodList.value,
            maxExtentValue: maxScrollExtent.value,
            foods: foods.value,
            dropDownCallBack: dropDownCallBack,
            itemPositionsListener: itemPositionsListener,
            verticalScrollController: verticalScrollController,
            addtoCartCallback: addToCartCallBack,
            atLeastOneItemSelected: atLeastOneItemSelected.value));
  }
}
