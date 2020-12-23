import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/services/provider/provider.dart';
import 'package:ari/services/services/restourant_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/provider/app_bar/app_bar_action.dart';
import 'package:ari/ui/provider/app_bar/app_bar_state.dart';
import 'package:ari/ui/provider/change_language/change_language_action.dart';
import 'package:ari/ui/provider/change_language/change_language_state.dart';
import 'package:ari/ui/views/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RestourantViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<UniqueKey> uniqueKey = useState<UniqueKey>();
    final localizationStore =
        useProvider<Store<ChangeLangState, ChangeLangAction>>();
    ApiResponse<RestourantList> apiResponse1 = useFetchRestourants('1',
        key: uniqueKey.value, lang: localizationStore.state.lang ?? 'az');
    ApiResponse apiResponse2 = useFetchRestourants('2',
        key: uniqueKey.value, lang: localizationStore.state.lang ?? 'az');
    ApiResponse apiResponse3 = useFetchRestourants('3',
        key: uniqueKey.value, lang: localizationStore.state.lang ?? 'az');

    useSideEffect(() {
      if (apiResponse1.status == Status.Done) {
        final store = getAppBarStore();
        store.dispatch(AppBarAction(message: apiResponse1.data.message ?? ''));
      }
      return () {};
    },[apiResponse1.status]);
    return CustomErrorHandler(
      statuses: [apiResponse1.status, apiResponse2.status, apiResponse3.status],
      errors: [apiResponse1.error, apiResponse2.error, apiResponse3.error],
      child: HomeView(
        restourantList1: apiResponse1?.data,
        restourantList2: apiResponse2?.data,
        restourantList3: apiResponse3?.data,
      ),
      onRefresh: () {
        uniqueKey.value = new UniqueKey();
      },
    );
  }
}
