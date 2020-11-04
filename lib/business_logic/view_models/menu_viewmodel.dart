import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/menu.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/services/services/menu_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/food/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class MenuViewModel extends HookWidget {
  final String id;
  final ScrollController scrollController;
  List<Food> foodList;
  int index = 0;

  MenuViewModel({this.id, this.scrollController, this.foodList});

  @override
  Widget build(BuildContext context) {
    //useFetchMenu(id)
    final ValueNotifier<ApiResponse<List<Menu>>> apiResponse =
        useState<ApiResponse<List<Menu>>>();
    apiResponse.value=useFetchMenu(id);
    useEffect(() {

      print('Chnaged');
      return () {};
    }, [id,]);
    // TODO: implement build
    return CustomErrorHandler(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: MenuItem(menu: apiResponse.value.data[index]),
            onTap: () {
              apiResponse.value.data[index].selected = true;
              print('On click');
              print(apiResponse.value.data[0].selected);
              for (int i = 0; i < foodList.length; i++) {
                if (foodList[i].menu_id == apiResponse.value.data[index].id) {
                  scrollController.animateTo(i * 120.toHeight,
                      duration: Duration(seconds: 2), curve: Curves.ease);
                }
              }
            },
          );
        },
        itemCount: apiResponse.value.data?.length,
        scrollDirection: Axis.horizontal,
      ),
      statuses: [apiResponse.value.status],
      errors: [apiResponse.value.error],
    );
  }
}
