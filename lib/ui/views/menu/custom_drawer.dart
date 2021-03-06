import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/localization/app_localization.dart';
import 'package:ari/services/provider/provider.dart';
import 'package:ari/ui/provider/change_language/change_language_action.dart';
import 'package:ari/ui/provider/change_language/change_language_state.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';
import '../../common_widgets/custom_appbar.dart';

class CustomMenuDrawer extends HookWidget {
  Function onClose;
  var changeMenuPositionCallBack;
  var value;

  CustomMenuDrawer({this.onClose, this.changeMenuPositionCallBack, this.value});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> menuPositionLeft = useState<bool>(value);
    final store = useProvider<Store<ChangeLangState, ChangeLangAction>>();
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
                  Text(
                      AppLocalizations.of(context).translate('????????') ?? '????????'),
                  SizedBox(
                    height: 8.toHeight,
                  ),
                  InkWell(
                    child: Text(
                      AppLocalizations.of(context).translate('?? ??????') ??
                          '?? ??????',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.toFont),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      pushRouteWithName(ROUTE_HTML,
                          arguments: RouteArguments<String>(data: 'aboutus'));
                    },
                  ),
                  SizedBox(
                    height: 8.toHeight,
                  ),
                  InkWell(
                    child: Text(
                      AppLocalizations.of(context).translate('??????????') ??
                          '??????????',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.toFont),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      pushRouteWithName(ROUTE_HTML,
                          arguments:
                              RouteArguments<String>(data: 'promotions'));
                    },
                  ),
                  SizedBox(
                    height: 8.toHeight,
                  ),
                  InkWell(
                    child: Text(
                      AppLocalizations.of(context).translate('????????????????') ??
                          '????????????????',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.toFont),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      pushRouteWithName(ROUTE_HTML,
                          arguments: RouteArguments<String>(data: 'vacancy'));
                    },
                  ),
                  SizedBox(
                    height: 8.toHeight,
                  ),
                  InkWell(
                    child: Text(
                      AppLocalizations.of(context).translate('Contacts') ??
                          'Contacts',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22.toFont),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      pushRouteWithName(ROUTE_HTML,
                          arguments: RouteArguments<String>(data: 'contacts'));
                    },
                  ),
                  SizedBox(
                    height: 24.toHeight,
                  ),
                  Text(
                    AppLocalizations.of(context).translate('????????') ?? '????????',
                  ),
                  SizedBox(
                    height: 4.toHeight,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(8.toWidth),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ThemeColor().greenColor.withOpacity(
                                    store.state.lang == 'az' ? 0.4 : 0)),
                            child: Text(
                              'AZ',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          onTap: () {
                            store.dispatch(ChangeLangAction(langugae: 'az'));
                            Navigator.of(context).pop();
                          },
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(8.toWidth),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ThemeColor().greenColor.withOpacity(
                                    store.state.lang == 'en' ? 0.4 : 0)),
                            child: Text(
                              'EN',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          onTap: () {
                            store.dispatch(ChangeLangAction(langugae: 'en'));
                            Navigator.of(context).pop();
                          },
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(8.toWidth),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ThemeColor().greenColor.withOpacity(
                                    store.state.lang == 'ru' ? 0.4 : 0)),
                            child: Text(
                              'RU',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          onTap: () {
                            store.dispatch(ChangeLangAction(langugae: 'ru'));
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(
                        right: 50.toWidth, top: 8.toHeight, bottom: 8.toHeight),
                  ),
                  SizedBox(
                    height: 24.toWidth,
                  ),
                  Text(AppLocalizations.of(context).translate('???????????? ????????') ??
                      '???????????? ????????'),
                  SizedBox(
                    height: 8.toHeight,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).translate('??????????') ??
                              '??????????',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.toFont),
                        ),
                        Switch(
                          value: menuPositionLeft.value,
                          onChanged: (valueMenu) {
                            menuPositionLeft.value = valueMenu;
                            changeMenuPositionCallBack(valueMenu);
                          },
                          activeTrackColor: ThemeColor().yellowColor,
                          activeColor: Colors.white,
                          inactiveTrackColor: ThemeColor().yellowColor,
                          inactiveThumbColor: Colors.white,
                        ),
                        Text(
                          AppLocalizations.of(context).translate('????????????') ??
                              '????????????',
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
