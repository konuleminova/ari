import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/services/services/restourant_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/home/home.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RestourantViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse1 = useFetchRestourants('1');
    ApiResponse apiResponse2 = useFetchRestourants('2');
    ApiResponse apiResponse3 = useFetchRestourants('3');
//    useSideEffect(() {
//      return () {};
//    }, [apiResponse1]);
//    useSideEffect(() {
//      return () {};
//    }, [apiResponse2]);
//    useSideEffect(() {
//      return () {};
//    }, [apiResponse3]);
    // TODO: implement build

    return CustomErrorHandler(
      statuses: [apiResponse1.status, apiResponse2.status, apiResponse3.status],
      errors: [apiResponse1.error, apiResponse2.error, apiResponse3.error],
      child: HomeView(
        restourantList1: apiResponse1?.data,
        restourantList2: apiResponse2?.data,
        restourantList3: apiResponse3?.data,
      ),
    );

    return ErrorHandler(
      status: apiResponse1.status,
      error: apiResponse1.error,
      child: HomeView(
        restourantList1: apiResponse1?.data,
        restourantList2: apiResponse2?.data,
        restourantList3: apiResponse3?.data,
      ),
    );
  }
}
