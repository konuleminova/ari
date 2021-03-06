import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/localization/app_localization.dart';
import 'package:ari/utils/size_config.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  var loginController;
  var passController;
  var loginCallBack;

  LoginView({this.loginController, this.passController, this.loginCallBack});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login_background.png'))),
          height: SizeConfig().screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 16.toWidth,right: 16.toWidth,top: 16.toHeight),
                width: SizeConfig().screenWidth,
                alignment: Alignment.topLeft,
                child: Text(
                  AppLocalizations.of(context).translate('Войти в систему') ??
                      'Войти в систему',
                  style: TextStyle(
                      fontSize: 14.toFont, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 34.toHeight,
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 44.toWidth),
                elevation: 16,
                child: Container(
                  // height: 200.toWidth,
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
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: loginController,
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
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.toHeight,
                      ),
                      InkWell(
                        child: Container(
                          height: 44.toHeight,
                          width: SizeConfig().screenWidth,
                          decoration:
                              BoxDecoration(color: ThemeColor().yellowColor),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)
                                      .translate('Войти в систему') ??
                                  'Войти в систему',
                            ),
                          ),
                        ),
                        onTap: () {
                          loginCallBack();
                        },
                      ),
                      InkWell(
                        child: Center(
                            child: Padding(
                          child: Text(
                            AppLocalizations.of(context)
                                    .translate('Зарегистрироватся') ??
                                'Зарегистрироватся',
                            style: TextStyle(color: Color(0xFF6ED34A)),
                          ),
                          padding: EdgeInsets.only(top: 16.toHeight),
                        )),
                        onTap: () {
                          pushRouteWithName(ROUTE_REGISTER);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
