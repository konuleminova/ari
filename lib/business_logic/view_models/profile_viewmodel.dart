import 'package:ari/business_logic/models/status.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/services/services/profile_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/common_widgets/loading.dart';
import 'package:ari/ui/provider/app_bar/app_bar_action.dart';
import 'package:ari/ui/provider/app_bar/app_bar_state.dart';
import 'package:ari/ui/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProfileViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ApiResponse<dynamic> apiResponse = useUserPage();

    useSideEffect(() {
      return () => WidgetsBinding.instance.addPostFrameCallback(
          (_) => getAppBarStore().dispatch(AppBarAction(index: 0)));
    }, []);
    return CustomErrorHandler(
      child: apiResponse.status != Status.Loading
          ? ProfileView(
              apiResponse: apiResponse,
            )
          : Loading(),
      statuses: [apiResponse.status],
      onRefresh: (){

      },
      errors: [apiResponse.error],
    );
  }
}
