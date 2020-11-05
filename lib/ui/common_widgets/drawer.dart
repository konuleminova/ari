import 'package:ari/ui/common_widgets/custom_appbar.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class CustomMenuDrawer extends HookWidget {
  bool isLeft = false;
  Function onClose;

  CustomMenuDrawer({this.onClose});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              child: Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(bottom: 70.toHeight),
                child: Image.asset(
                  'assets/images/menu.png',
                  height: 80.toWidth,
                  width: 80.toWidth,
                  alignment: Alignment.bottomRight,
                ),
              ),
              onTap: () {
                onClose();
              },
            ),
            Expanded(
              child: Container(
                height: SizeConfig().screenHeight -
                    CustomAppBar().preferredSize.height * 2.2,
                width: SizeConfig().screenWidth,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(24.toHeight),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: ThemeColor().greenLightColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Меню'),
                    SizedBox(
                      height: 8.toHeight,
                    ),
                    Text(
                      'О нас',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.toFont),
                    ),
                    SizedBox(
                      height: 8.toHeight,
                    ),
                    Text(
                      'Акции',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.toFont),
                    ),
                    SizedBox(
                      height: 8.toHeight,
                    ),
                    Text(
                      'Вакансии',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.toFont),
                    ),
                    SizedBox(
                      height: 8.toHeight,
                    ),
                    Text(
                      'Контакты',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.toFont),
                    ),
                    SizedBox(
                      height: 24.toHeight,
                    ),
                    Text(
                      'Язык',
                    ),
                    SizedBox(
                      height: 4.toHeight,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('AZ',style: TextStyle(fontWeight: FontWeight.w600),),
                          Text('EN',style: TextStyle(fontWeight: FontWeight.w600),),
                          Container(
                            padding: EdgeInsets.all(8.toWidth),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    ThemeColor().greenColor.withOpacity(0.4)),
                            child: Text('RU',style: TextStyle(fontWeight: FontWeight.w600),),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(
                          right: 50.toWidth,
                          top: 8.toHeight,
                          bottom: 8.toHeight),
                    ),
                    SizedBox(
                      height: 24.toWidth,
                    ),
                    Text('Кнопка меню'),
                    SizedBox(
                      height: 8.toHeight,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Слева',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.toFont),
                          ),
                          Switch(
                            value: isLeft,
                            onChanged: (value) {
                              isLeft = value;
                            },
                            activeTrackColor: Colors.white,
                            activeColor: ThemeColor().yellowColor,
                          ),
                          Text(
                            'Справа',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.toFont),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(
                        right: 24.toWidth,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
