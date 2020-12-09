import 'package:ari/business_logic/models/restourant.dart';
import 'food.dart';

class StatusModel {
  int found;
  List<Order> order;

  StatusModel.fromJson(Map<String, dynamic> json) {
    found = json['found'];
    order = listOrderFromJson(json['order']);
  }

  @override
  String toString() {
    return 'StatusModel{found: $found}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is StatusModel &&
              runtimeType == other.runtimeType &&
              found == other.found &&
              order == other.order;

  @override
  int get hashCode =>
      found.hashCode ^
      order.hashCode;



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
    restourant = json['restourant'] != null
        ? Restourant.fromJson(json['restourant'])
        : null;
    curyer = json['curyer'] != null ? Curyer.fromJson(json['curyer']) : null;
    foods = listFoodsFromJson(json['foods']);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Order &&
              runtimeType == other.runtimeType &&
              message == other.message &&
              statusNUM == other.statusNUM &&
              date == other.date &&
              orderid == other.orderid &&
              address == other.address &&
              coords == other.coords &&
              restourant == other.restourant &&
              curyer == other.curyer &&
              foods == other.foods;

  @override
  int get hashCode =>
      message.hashCode ^
      statusNUM.hashCode ^
      date.hashCode ^
      orderid.hashCode ^
      address.hashCode ^
      coords.hashCode ^
      restourant.hashCode ^
      curyer.hashCode ^
      foods.hashCode;


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

  @override
  String toString() {
    return 'Curyer{id: $id, name: $name, coords: $coords, mobile: $mobile}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Curyer &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              coords == other.coords &&
              mobile == other.mobile;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      coords.hashCode ^
      mobile.hashCode;


}
