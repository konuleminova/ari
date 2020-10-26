import 'package:ari/business_logic/models/food.dart';

class Menu extends Food {
  Menu.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}

List<Menu> menuListFromJson(List<dynamic> menuList) =>
    List<Menu>.from(menuList.map((e) => Menu.fromJson(e)));
