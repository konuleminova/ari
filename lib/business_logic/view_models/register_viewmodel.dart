import 'package:ari/business_logic/models/user.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/services/services/profile.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/profile/register.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RegisterViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final loginController = useTextEditingController(text: '');
    final passController = useTextEditingController(text: '');
    final nameController = useTextEditingController(text: '');
    final emailController = useTextEditingController(text: '');
    final phoneController = useTextEditingController(text: '');
    var login = useState<String>('');
    var password = useState<String>('');
    var name = useState<String>('');
    var email = useState<String>('');
    var phone = useState<String>('');
    var loginKey = useState<UniqueKey>();
    final user = useState<User>(User(
        login: login.value,
        pass: password.value,
        name: name.value,
        email: email.value,
        number: phone.value));
    ApiResponse<User> apiResponse = useRegister(user.value, loginKey.value);

    //GET TOKEN STATUS
    useSideEffect(() {
      print('Api response ${apiResponse.data}');
      if (apiResponse?.data?.token != null) {
        SpUtil.putString(SpUtil.token, apiResponse?.data?.token);
        pushReplaceRouteWithName(ROUTE_PROFILE);
      }
      return () {};
    }, [apiResponse]);

    //LOGIN CALLBACK
    final registerCallBack = useCallback(() {
      if (loginController.text != null &&
          passController.text != null &&
          loginController.text.isNotEmpty &&
          passController.text.isNotEmpty) {
        login.value = loginController.text;
        password.value = passController.text;
        name.value = nameController.text;
        email.value = emailController.text;
        phone.value = phoneController.text;
        user.value = User(
            login: login.value,
            pass: password.value,
            device_token: '%7BDEVICE_TOKEN%7D');
        // loginKey.value = UniqueKey();
      }
    }, [login.value, password.value]);

    // TODO: implement build
    return CustomErrorHandler(
      errors: [apiResponse.error],
      statuses: [apiResponse.status],
      child: RegisterView(
          loginController: loginController,
          passController: passController,
          nameController: nameController,
          emailController: emailController,
          phoneController: phoneController,
          registerCallBack: registerCallBack),
    );
  }
}
