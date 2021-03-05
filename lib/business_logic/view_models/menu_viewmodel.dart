import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/menu.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/menu_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/food/widgets/menu_item/menu_item.dart';
import 'package:ari/ui/views/food/widgets/food_item/food_item_expanded.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuViewModel extends HookWidget {
  final String id;
  ItemScrollController verticalScrollController;
  List<Food> foodList;
  ApiResponse<List<Menu>> menuList;
  ItemPositionsListener itemPositionsListener;

  MenuViewModel(
      {this.id,
      this.verticalScrollController,
      this.foodList,
      this.itemPositionsListener});

  @override
  Widget build(BuildContext context) {
    var apiResponse = useState<ApiResponse<List<Menu>>>();
    var horizontalScrollController =
        useState<ItemScrollController>(new ItemScrollController());
    apiResponse.value = useFetchMenu(id);
    useEffect(() {
      if (apiResponse.value.status == Status.Done) {
        apiResponse.value.data[0].selected = true;
      }
      return () {};
    }, [apiResponse.value]);
    var indexState = useState<int>();

    //Horizontall Item Selection
    useEffect(() {
      if (apiResponse.value.status == Status.Done) {
        for (int i = 0; i < apiResponse.value.data.length; i++) {
          if (foodList[indexState.value].menu_id ==
              apiResponse.value.data[i].id) {
            apiResponse.value.data[i].selected = true;
            if (horizontalScrollController.value.isAttached) {
              try {
                if (itemPositionsListener.itemPositions.value.isNotEmpty) {
                  horizontalScrollController.value.scrollTo(
                      index: i == 0 ? 0 : i - 1,
                      duration: Duration(milliseconds: 300));
                }
              } catch (e) {
              }
            }
          } else {
            apiResponse.value.data[i].selected = false;
          }
        }
      }

      return () {};
    }, [indexState.value]);

    //Vertical Scrolling set horizontal selection
    useEffect(() {
      itemPositionsListener.itemPositions.addListener(() {
        var isElement = itemPositionsListener.itemPositions.value
            .firstWhere((element) => element != null, orElse: () => null);
        if (isElement != null &&
            itemPositionsListener.itemPositions.value.isNotEmpty) {
          indexState.value = isElement.index;
        }
      });
      return () {};
    }, [itemPositionsListener]);

    // TODO: implement build
    return CustomErrorHandler(
      child: ScrollablePositionedList.builder(
        itemScrollController: horizontalScrollController.value,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: MenuItem(menu: apiResponse.value.data[index]),
            onTap: () {
              if (apiResponse.value.status == Status.Done) {
                for (int i = 0; i < apiResponse.value.data.length; i++) {
                  if (i != index) {
                    apiResponse.value.data[i].selected = false;
                  } else {
                    if (i != 0) {
                      apiResponse.value.data[0].selected = false;
                    }
                    apiResponse.value.data[i].selected = true;
                    if (horizontalScrollController.value.isAttached) {
                      try {
                        horizontalScrollController.value.scrollTo(
                            index: i == 0 ? 0 : i - 1,
                            duration: Duration(milliseconds: 10));
                      } catch (e) {
                      }
                    }
                    break;
                  }
                }
                apiResponse.notifyListeners();
                for (int i = 0; i < foodList.length; i++) {
                  if (apiResponse.value.data[index].id == foodList[i].menu_id) {
                    if (verticalScrollController.isAttached) {
                      verticalScrollController.jumpTo(
                        // duration: Duration(milliseconds: 40),
                        index: i,
                      );
                    }
                    break;
                  }
                }
              }
            },
          );
        },
        itemCount: apiResponse.value.data?.length ?? 0,
        scrollDirection: Axis.horizontal,
      ),
      statuses: [apiResponse.value.status],
      errors: [apiResponse.value.error],
    );
  }
}
