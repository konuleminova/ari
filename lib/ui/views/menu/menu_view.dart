import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/ui/common_widgets/custom_appbar.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

import 'custom_drawer.dart';

class MenuView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> menuPositionLeft = useState<bool>(true);

    //change Menu Position callback
    final changeMenuPositionCallBack = useCallback((bool value) {
      menuPositionLeft.value = value;
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
