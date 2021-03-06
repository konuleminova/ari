import 'package:ari/business_logic/models/restourant.dart';
import 'food.dart';

class StatusModel {
  int found;
  List<Order> order;

  StatusModel.fromJson(Map<String, dynamic> json) {
    found = json['found'];
    order = json['found'] > 0
        ? listOrderFromJson(json['data'] == null ? json['order'] : json['data'])
        : [];
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
  int get hashCode => found.hashCode ^ order.hashCode;
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
  var final_price;
  var hasCountdown;
  var countDownMins;
  var countDownMessage;
  int index;
  var totalpricemessage;

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
    final_price = json['final_price'];
    hasCountdown = json['hasCountdown'];
    countDownMins = json['countDownMins'];
    countDownMessage = json['countDownMessage'];
    totalpricemessage = json['totalpricemessage'];
  }

  @override
  String toString() {
    return 'Order{message: $message, statusNUM: $statusNUM, date: $date, orderid: $orderid, address: $address, coords: $coords, restourant: $restourant, curyer: $curyer, foods: $foods, final_price: $final_price, hasCountdown: $hasCountdown, countDownMins: $countDownMins, countDownMessage: $countDownMessage, index: $index}';
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
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    coords = json['coords'] ?? '';
    mobile = json['mobile'] ?? '';
  }

  @override
  String toString() {
    return 'Curyer{id: $id, name: $name, coords: $coords, mobile: $mobile}';
  }
}
