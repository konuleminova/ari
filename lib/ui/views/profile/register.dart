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

  RegisterView(
      {this.loginController,
      this.passController,
      this.nameController,
      this.emailController,
      this.phoneController,
      this.registerCallBack});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login_background.png'))),
      height: SizeConfig().screenHeight,
      width: SizeConfig().screenWidth,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.toWidth),
            width: SizeConfig().screenWidth,
            alignment: Alignment.topLeft,
            child: Text(
              'Регистрация',
              style:
                  TextStyle(fontSize: 14.toFont, fontWeight: FontWeight.w500),
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsets.all(28.toWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: loginController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.toHeight,
                  ),
                  Text(
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.toHeight,
                  ),
                  Text(
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
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.toHeight,
                  ),
                  Text(
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.toHeight,
                  ),
                  Text(
                    'Номер телефона',
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
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.toHeight,
                  ),
                  Container(
                    child: RadioListTile(
                      value: false,
                      groupValue: false,
                      dense: false,
                      onChanged: (v) {},
                      title: Text(
                        'Согласен с условиями',
                        style: TextStyle(fontSize: 12.toFont),
                      ),
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
                        child: Text('Войти в систему'),
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
