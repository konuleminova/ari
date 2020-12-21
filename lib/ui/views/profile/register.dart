import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/localization/app_localization.dart';
import 'package:ari/ui/views/init.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  var loginController;
  var passController;
  var nameController;
  var emailController;
  var phoneController;
  var registerCallBack;
  var onChangeRadioValueCallBack;
  var radioValue;

  var loginerror;
  var passworderror;
  var nameerror;
  var emailerror;
  var phoneerror;

  RegisterView(
      {this.loginController,
      this.passController,
      this.nameController,
      this.emailController,
      this.phoneController,
      this.loginerror,
      this.passworderror,
      this.nameerror,
      this.emailerror,
      this.phoneerror,
      this.registerCallBack,
      this.radioValue,
      this.onChangeRadioValueCallBack});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login_background.png'))),
          // height: SizeConfig().screenHeight,
          // width: SizeConfig().screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.toWidth),
                width: SizeConfig().screenWidth,
                alignment: Alignment.topLeft,
                child: Text(
                  AppLocalizations.of(context).translate('Регистрация') ??
                      'Регистрация',
                  style: TextStyle(
                      fontSize: 14.toFont, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 8.toHeight,
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 44.toWidth),
                elevation: 16,
                child: Container(
                  width: SizeConfig().screenWidth,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4)),
                  padding: EdgeInsets.all(28.toWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('Логин') ??
                            'Логин',
                        style: TextStyle(fontSize: 14.toFont),
                      ),
                      SizedBox(
                        height: 4.toHeight,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: TextField(
                          controller: loginController,
                          decoration: InputDecoration(
                              border: InputBorder.none, errorText: loginerror),
                        ),
                      ),
                      SizedBox(
                        height: 16.toHeight,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('Пароль') ??
                            'Пароль',
                        style: TextStyle(fontSize: 14.toFont),
                      ),
                      SizedBox(
                        height: 4.toHeight,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: TextField(
                          controller: passController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorText: passworderror),
                        ),
                      ),
                      SizedBox(
                        height: 16.toHeight,
                      ),
                      Text(
                        AppLocalizations.of(context)
                                .translate('Имя и Фамилия') ??
                            'Имя и Фамилия',
                        style: TextStyle(fontSize: 14.toFont),
                      ),
                      SizedBox(
                        height: 4.toHeight,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              border: InputBorder.none, errorText: nameerror),
                        ),
                      ),
                      SizedBox(
                        height: 16.toHeight,
                      ),
                      Text(
                        AppLocalizations.of(context).translate('E-mail') ??
                            'E-mail',
                        style: TextStyle(fontSize: 14.toFont),
                      ),
                      SizedBox(
                        height: 4.toHeight,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.toHeight,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('mobile_title'),
                              style: TextStyle(
                                  color: ThemeColor().greyColor,
                                  fontSize: 10.toFont),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(
                            width: 4.toWidth,
                          ),
                          Icon(
                            Icons.info,
                            color: ThemeColor().grey1,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16.toHeight,
                      ),

                      Text(
                        AppLocalizations.of(context)
                                .translate("Номер телефона") ??
                            "Номер телефона",
                        style: TextStyle(fontSize: 14.toFont),
                      ),
                      SizedBox(
                        height: 4.toHeight,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          decoration: InputDecoration(
                              border: InputBorder.none, errorText: phoneerror),
                        ),
                      ),
                      SizedBox(
                        height: 8.toHeight,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('mobile_title'),
                              style: TextStyle(
                                  color: ThemeColor().greyColor,
                                  fontSize: 10.toFont),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          SizedBox(
                            width: 4.toWidth,
                          ),
                          Icon(
                            Icons.info,
                            color: ThemeColor().grey1,
                          )
                        ],
                      ),
                      Container(
                        child: Row(
                          children: [
                            Checkbox(
                              value: radioValue,
                              onChanged: (v) {
                                onChangeRadioValueCallBack(v);
                              },
                            ),
                            InkWell(
                              child: Container(
                                child: Text(
                                  AppLocalizations.of(context)
                                          .translate("Согласен с условиями") ??
                                      "Согласен с условиями",
                                  style: TextStyle(fontSize: 12.toFont),
                                ),
                                padding: EdgeInsets.all(16),
                              ),
                              onTap: () {
                                pushRouteWithName(ROUTE_HTML,
                                    arguments: RouteArguments<String>(
                                        data: 'confidential'));
                              },
                            )
                          ],
                        ),
                        width: SizeConfig().screenWidth,
                        alignment: Alignment.topLeft,
                      ),
                      SizedBox(
                        height: 8.toHeight,
                      ),
                      InkWell(
                        child: Container(
                          height: 44.toHeight,
                          width: SizeConfig().screenWidth,
                          decoration:
                              BoxDecoration(color: ThemeColor().yellowColor),
                          child: Center(
                            child: Text(AppLocalizations.of(context)
                                    .translate("Войти в систему") ??
                                "Войти в систему"),
                          ),
                        ),
                        onTap: () {
                          registerCallBack();
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24.toHeight,
              )
            ],
          )),
    );
  }
}
