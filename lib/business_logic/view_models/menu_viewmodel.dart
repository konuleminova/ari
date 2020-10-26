import 'package:ari/business_logic/models/menu.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/menu_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/food/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MenuViewModel extends HookWidget {
  final String id;

  MenuViewModel({this.id});

  @override
  Widget build(BuildContext context) {
    ApiResponse<List<Menu>> apiResponse = useFetchMenu(id);
    useEffect(() {
      return () {};
    },[id]);

    // TODO: implement build
    return ErrorHandler(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return MenuItem(menu: apiResponse.data[index]);
        },
        itemCount: apiResponse.data?.length,
        scrollDirection: Axis.horizontal,
      ),
      status: apiResponse.status,
      error: apiResponse.error,
    );
  }
}
