class Food {
  String id;
  String name;
  String price;
  String information;
  String image;
  String menu_id;
  String restourant_id;
  bool selected = false;
  int count = 1;
  List<Adds> adds;
  List<Adds> addsType2=[];
  double totalPrice=0;

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    information = json['information'];
    image = json['image'];
    menu_id = json['menu_id'];
    restourant_id = json['restourant_id'];
    adds = listAddsFromJsom(json['adds']);
  }

  @override
  String toString() {
    return 'Food{id: $id, name: $name, price: $price, information: $information, image: $image, menu_id: $menu_id, restourant_id: $restourant_id, adds: $adds}';
  }
}

List<Food> listFoodsFromJson(List<dynamic> foodlist) =>
    List<Food>.from(foodlist.map((e) => Food.fromJson(e)));

class GroupFood {
  String name;
  List<Food> foods;

  GroupFood.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    foods = listFoodsFromJson(json['foods']);
  }
}

List<GroupFood> listGroupFoodFromJson(List<dynamic> groupFoods) =>
    List<GroupFood>.from(groupFoods.map((e) => GroupFood.fromJson(e)));

class Adds {
  String name;
  int type;
  String price;
  int count=0;

  Adds.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    price = json['price'].toString().replaceAll(',', '.');
  }
}

listAddsFromJsom(List<dynamic> listAdds) =>
    List<Adds>.from(listAdds.map((e) => Adds.fromJson(e)));
