import 'package:ari/business_logic/models/food.dart';

class Menu{
  String id;
  String name;
  bool selected=false;
  Menu.fromJson(Map<String, dynamic> json){
    id=json['id'];
    name=json['name'];
  }
}

List<Menu> menuListFromJson(List<dynamic> menuList) =>
    List<Menu>.from(menuList.map((e) => Menu.fromJson(e)));
