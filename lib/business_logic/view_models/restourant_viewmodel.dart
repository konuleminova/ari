import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/restourant_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RestourantViewModel extends HookWidget {

  @override
  Widget build(BuildContext context) {
   final ValueNotifier<UniqueKey>uniqueKey=useState<UniqueKey>();
    ApiResponse apiResponse1 = useFetchRestourants('1', key: uniqueKey.value);
    ApiResponse apiResponse2 = useFetchRestourants('2',key: uniqueKey.value);
    ApiResponse apiResponse3 = useFetchRestourants('3',key: uniqueKey.value);

    return CustomErrorHandler(
      statuses: [apiResponse1.status, apiResponse2.status, apiResponse3.status],
      errors: [apiResponse1.error, apiResponse2.error, apiResponse3.error],
      child: HomeView(
        restourantList1: apiResponse1?.data,
        restourantList2: apiResponse2?.data,
        restourantList3: apiResponse3?.data,
      ),
      onRefresh: () {
        uniqueKey.value=new UniqueKey();
      },
    );
  }
}
