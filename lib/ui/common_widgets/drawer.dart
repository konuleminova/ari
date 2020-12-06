import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/ui/common_widgets/custom_appbar.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class MenuView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> menuPositionLeft = useState<bool>(true);

    //change Menu Position callback
    final changeMenuPositionCallBack = useCallback((bool value) {
      menuPositionLeft.value = value;
      print('DRAWER VALUE ${value}');
    }, [menuPositionLeft.value]);

    void showMenu() {
      showGeneralDialog(
        barrierLabel: "Label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.4),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Stack(
            children: <Widget>[
              Positioned(
                  top: CustomAppBar().preferredSize.height + 30.toHeight,
                  left: 0,
                  right: 0,
                  child: Align(
                    child: CustomMenuDrawer(
                      value: menuPositionLeft.value,
                      changeMenuPositionCallBack: changeMenuPositionCallBack,
                      onClose: () {
                        Navigator.pop(context);
                      },
                    ),
                    alignment: Alignment.bottomRight,
                  ))
            ],
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(
                    begin:
                        menuPositionLeft.value ? Offset(1, 0) : Offset(-1, 0),
                    end: menuPositionLeft.value ? Offset(0, 0) : Offset(0, 0))
                .animate(anim1),
            child: child,
          );
        },
      );
    }

    // TODO: implement build
    return !menuPositionLeft.value
        ? Positioned(
            left: 0,
            bottom: 140.toHeight,
            child: GestureDetector(
              child: Container(
                child: Image.asset(
                  'assets/images/menu_left.png',
                  height: 80.toWidth,
                  width: 80.toWidth,
                  alignment: Alignment.centerLeft,
                ),
              ),
              onHorizontalDragStart: (v) {
                showMenu();
              },
              onTap: () {
                showMenu();
              },
            ))
        : Positioned(
            right: 0,
            bottom: 140.toHeight,
            child: GestureDetector(
              child: Container(
                child: Image.asset(
                  'assets/images/menu.png',
                  height: 80.toWidth,
                  width: 80.toWidth,
                  alignment: Alignment.centerRight,
                ),
              ),
              onHorizontalDragStart: (v) {
                showMenu();
              },
              onTap: () {
                showMenu();
              },
            ));
  }
}

class CustomMenuDrawer extends HookWidget {
  Function onClose;
  var changeMenuPositionCallBack;
  var value;

  CustomMenuDrawer({this.onClose, this.changeMenuPositionCallBack, this.value});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> menuPositionLeft = useState<bool>(value);
    // TODO: implement build
    return Material(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            menuPositionLeft.value
                ? GestureDetector(
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
                    onHorizontalDragStart: (v) {
                      onClose();
                    },
                  )
                : SizedBox(),
            Container(
              height: SizeConfig().screenHeight -
                  CustomAppBar().preferredSize.height * 2.2,
              width: SizeConfig().screenWidth - 80.toWidth,
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
                        Text(
                          'AZ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'EN',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.toWidth),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ThemeColor().greenColor.withOpacity(0.4)),
                          child: Text(
                            'RU',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(
                        right: 50.toWidth, top: 8.toHeight, bottom: 8.toHeight),
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
                              fontWeight: FontWeight.bold, fontSize: 18.toFont),
                        ),
                        Switch(
                          value: menuPositionLeft.value,
                          onChanged: (valueMenu) {
                            menuPositionLeft.value = valueMenu;
                            print('VAlUE MENU ${valueMenu}');
                            changeMenuPositionCallBack(valueMenu);
                          },
                          activeTrackColor: ThemeColor().yellowColor,
                          activeColor: Colors.white,
                          inactiveTrackColor: ThemeColor().yellowColor,
                          inactiveThumbColor: Colors.white,
                        ),
                        Text(
                          'Справа',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.toFont),
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
            Expanded(
              child: !menuPositionLeft.value
                  ? GestureDetector(
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(bottom: 70.toHeight),
                        child: Image.asset(
                          'assets/images/menu_left.png',
                          height: 80.toWidth,
                          width: 80.toWidth,
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                      onTap: () {
                        onClose();
                      },
                      onHorizontalDragStart: (v) {
                        onClose();
                      },
                    )
                  : SizedBox(),
            )
          ],
        ));
  }
}
