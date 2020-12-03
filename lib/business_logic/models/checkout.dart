import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';

class Checkout {
  List<GroupFood> foodList;

  Restourant restourant;
  String totalPrice;
  String address;
  String coords;

  @override
  String toString() {
    return 'Checkout{foodList: $foodList, restourant: $restourant, totalPrice: $totalPrice}';
  }

  Checkout(
      {this.foodList,
      this.restourant,
      this.totalPrice,
      this.address,
      this.coords});
}
