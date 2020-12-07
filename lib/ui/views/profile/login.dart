import 'package:ari/utils/size_config.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/login_background.png'))),
      height: SizeConfig().screenHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16.toWidth),
            width: SizeConfig().screenWidth,
            alignment: Alignment.topLeft,
            child: Text(
              'Войти в систему',
              style: TextStyle(fontSize: 14.toFont,fontWeight: FontWeight.w500),
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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              padding: EdgeInsets.all(28.toWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Логин',
                    style: TextStyle(fontSize: 14.toFont),
                  ),
                  SizedBox(height: 4.toHeight,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4)),
                    child: TextField(
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
                  SizedBox(height: 4.toHeight,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4)),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.toHeight,
                  ),
                  Container(
                    height: 44.toHeight,
                    width: SizeConfig().screenWidth,
                    decoration: BoxDecoration(color: ThemeColor().yellowColor),
                    child: Center(
                      child: Text('Войти в систему'),
                    ),
                  ),
                  SizedBox(
                    height: 16.toHeight,
                  ),
                  Center(
                    child: Text(
                      'Зарегистрироватся',
                      style: TextStyle(color: Color(0xFF6ED34A)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
