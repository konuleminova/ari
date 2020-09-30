class Product {
  //String text;
var number;

  Product.fromJson(Map<String, dynamic> json) {
   // text = json['text'];
    number=json['number'];
  }

  @override
  String toString() {
    return 'Product{number: $number}';
  }

}

