import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/menu.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/menu_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/food/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuViewModel extends HookWidget {
  final String id;
  ItemScrollController verticalScrollController;
  ItemScrollController horizontalScrollController = new ItemScrollController();
  List<GroupFood> foodList;
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
    apiResponse.value = useFetchMenu(id);
    var indexState = useState<int>();

    useEffect(() {
      return () {};
    }, [id]);

    //Horizontall Item Selection
    useEffect(() {
      if (apiResponse.value.status == Status.Done) {
        for (int i = 0; i < apiResponse.value.data.length; i++) {
          if (indexState.value == i) {
            apiResponse.value.data[i].selected = true;
            if (horizontalScrollController.isAttached) {
              try {
                horizontalScrollController.scrollTo(
                    index: i == 0 ? 0 : i - 1,
                    duration: Duration(milliseconds: 300));
              } catch (e) {
                print('Horizontal scroll exception ${e}');
              }
            }
          } else {
            apiResponse.value.data[i].selected = false;
          }
        }
      }

      return () {};
    }, [indexState.value, apiResponse.value.status]);

    //Vertical Scrolling set horizontal selection
    useEffect(() {
      itemPositionsListener.itemPositions.addListener(() {
        var isElement = itemPositionsListener.itemPositions.value
            .firstWhere((element) => element != null, orElse: () => null);
        if (isElement != null) {
          indexState.value = isElement.index;
        }
      });
      return () {};
    }, [itemPositionsListener]);

    // TODO: implement build
    return CustomErrorHandler(
      child: ScrollablePositionedList.builder(
        itemScrollController: horizontalScrollController,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: MenuItem(menu: apiResponse.value.data[index]),
            onTap: () {
              //Set selected Item
              indexState.value = index;
              for (int i = 0; i < foodList.length; i++) {
                if (foodList[i].name == apiResponse.value.data[index].name) {
                  if (verticalScrollController.isAttached) {
                    verticalScrollController.scrollTo(
                      duration: Duration(milliseconds: 40),
                      index: i,
                    );
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
