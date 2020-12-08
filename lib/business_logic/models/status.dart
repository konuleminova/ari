import 'package:ari/business_logic/models/restourant.dart';
import 'food.dart';

class StatusModel {
  int found;
  List<Order> order;

  StatusModel.fromJson(Map<String, dynamic> json) {
    found = json['found'];
    order = listOrderFromJson(json['order']);
  }
}

class Order {
  String message;
  String statusNUM;
  String date;
  String orderid;
  String address;
  String coords;
  Restourant restourant;
  Curyer curyer;
  List<Food> foods;

  Order.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusNUM = json['statusNUM'];
    date = json['date'];
    orderid = json['orderid'];
    address = json['address'];
    coords = json['coords'];
    restourant = Restourant.fromJson(json['restourant']);
    curyer = Curyer.fromJson(json['curyer']);
    foods = listFoodsFromJson(json['food']['data']);
  }
}

listOrderFromJson(List<dynamic> orderList) =>
    List<Order>.from(orderList.map((e) => Order.fromJson(e)));

class Curyer {
  String id;
  String name;
  String coords;
  String mobile;

  Curyer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coords = json['coords'];
    mobile = json['mobile'];
  }
}
