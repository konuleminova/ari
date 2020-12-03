import 'dart:convert';

import 'package:flutter/material.dart';

class PaymentItem {
  String restid;
  String cid;
  String number;
  List<Add> adds;

  PaymentItem({this.restid, this.cid, this.number, this.adds});

  Map<String, dynamic> toJson() {
    return {
      'restid': restid,
      'cid': cid,
      'number': number,
      'adds': adds
    };
  }

  @override
  String toString() {
    return 'PaymentItem{restid: $restid, cid: $cid, number: $number, adds: $adds}';
  }
}

class Add {
  String name;
  String price;
  String number;

  Add({this.name, this.price, this.number});

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'number': number};
  }

  @override
  String toString() {
    return 'Add{name: $name, price: $price, number: $number}';
  }
}
