import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';

class Checkout {
  List<GroupFood> foodList;

  Restourant restourant;
  String totalPrice;

  Checkout({this.foodList, this.restourant,this.totalPrice});
}
