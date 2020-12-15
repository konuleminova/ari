import 'package:ari/business_logic/models/checkout.dart';

class CheckoutAction {
  String address;
  String coords;
  bool isInPolygon;

  CheckoutAction(this.address,this.coords,this.isInPolygon);


}