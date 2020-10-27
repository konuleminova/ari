import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/models/search.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/search_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/home/widgets/restourant_item.dart';
import 'package:ari/ui/views/search/search.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ValueNotifier<TextEditingController> controller1;
ValueNotifier<TextEditingController> controller2;

class SearchViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    controller1 = useState<TextEditingController>();
    controller2 = useState<TextEditingController>();
    print('Controller ${controller1.value?.text}');
    ApiResponse<Search> apiResponse = useSearchList(
        controller1?.value?.text??'a',
        controller2?.value?.text??'10');
    useEffect(() {
      return () {};
    }, [controller1.value, controller2.value]);
    // print(apiResponse.data.results);

    // TODO: implement build
    return CustomErrorHandler(
      child: SearchView(
        controller1: controller1.value,
        controller2: controller2.value,
        search: apiResponse.data,
      ),
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
    );
  }
}

setText(String text) {
  print('COUNTER VALUE CHNAGES ${controller1.value.text}');
  controller1.value.text=text;


}

setNumberText(String text) {
  controller2.value.text=text;
}
