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
import 'package:flutter/material.dart';
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
    //error texts
    var loginerror = useState<String>();
    var passworderror = useState<String>();
    var nameerror = useState<String>();
    var emailerror = useState<String>();
    var phoneerror = useState<String>();
    var loginKey = useState<UniqueKey>();
    final user = useState<User>(User(
        login: login.value,
        pass: password.value,
        name: name.value,
        email: email.value,
        number: phone.value));
    ApiResponse<dynamic> apiResponse = useRegister(user.value, loginKey.value);

    //GET TOKEN STATUS
    useSideEffect(() {
      print('Api response ${apiResponse.data}');
      if (apiResponse.status == Status.Done) {
        if (apiResponse is User) {
          if (apiResponse?.data?.token != null) {
            SpUtil.putString(SpUtil.token, apiResponse?.data?.token);
            pushReplaceRouteWithName(ROUTE_PROFILE);
          }
        } else {
          AppException appException = apiResponse.data;
          apiResponse.error = appException;
          showDialog(
              context: context,
              builder: (BuildContext context) => ErrorDialog(
                    errorMessage: appException.message,
                  ));
        }
      }

      return () {};
    }, [apiResponse]);

    //LOGIN CALLBACK
    final registerCallBack = useCallback(() {
      {
        login.value = loginController.text;
        password.value = passController.text;
        name.value = nameController.text;
        email.value = emailController.text;
        phone.value = phoneController.text;
        if (login.value.isEmpty) {
          loginerror.value = 'Login bos ola bilmez';
        } else {
          loginerror.value = null;
        }
        if (password.value.isEmpty) {
          passworderror.value = 'Pass bos ola bilmez';
        } else {
          passworderror.value = null;
        }
        if (name.value.isEmpty) {
          nameerror.value = 'Ad bos ola bilmez';
        } else {
          nameerror.value = null;
        }

        if (email.value.isEmpty) {
          emailerror.value = 'Email bos ola bilmez';
        } else {
          emailerror.value = null;
        }
        if (phone.value.isEmpty) {
          phoneerror.value = 'Nomre bos ola bilmez';
        } else {
          phoneerror.value = null;
        }

        if (login.value.isNotEmpty &&
            password.value.isNotEmpty &&
            email.value.isNotEmpty &&
            name.value.isNotEmpty &&
            phone.value.isNotEmpty) {
          user.value = User(
              login: login.value,
              pass: password.value,
              name: name.value,
              email: email.value,
              number: phone.value);
          loginKey.value = UniqueKey();
        }
      }
    }, [login.value, password.value, name.value, email.value, phone.value]);

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
          registerCallBack: registerCallBack,
          loginerror: loginerror.value,
          passworderror: passworderror.value,
          nameerror: nameerror.value,
          emailerror: emailerror.value,
          phoneerror: phoneerror.value),
    );
  }
}
