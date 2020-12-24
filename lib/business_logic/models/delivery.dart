class Delivery {
  String delivery_price;
  String delivery_message;

  Delivery.fromJson(Map<String, dynamic> json) {
    delivery_price = json['deliveryprice'].toString();
    delivery_message = json['deliveryprice_message'] ?? '';
  }
}
