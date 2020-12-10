import 'package:ari/business_logic/models/status.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/profile_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProfileViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ApiResponse<StatusModel> apiResponse = useUserPage();
    return CustomErrorHandler(
      child: ProfileView(order: apiResponse.data,),
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
    );
  }
}
