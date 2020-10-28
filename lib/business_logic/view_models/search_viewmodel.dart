import 'package:ari/business_logic/models/search.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/services/services/search_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller1 = useTextEditingController();
    final controller2 = useTextEditingController();
    final ValueNotifier<String> text1 = useState<String>();
    final ValueNotifier<String> text2 = useState<String>();
    final search = useCallback(() {
      text1.value = controller1.text;
      text2.value = controller2.text;
    }, []);

    ApiResponse<Search> apiResponse = useSearchList(
        (text1.value==null||text1?.value?.isEmpty)? 'a':text1.value,
        (text2.value==null||text2.value.isEmpty)? '':text2.value);

    // TODO: implement build
    return CustomErrorHandler(
      child: SearchView(
        controller1: controller1,
        controller2: controller2,
        search: apiResponse.data,
        onChangeValue: search,
      ),
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
    );
  }
}
