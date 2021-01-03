class Product {
  String id;
  String image;
  String name;
  String description;
  double price;
  double special;
  double tax;
  double minimum;
  int rating;
  String link;

  Product.fromJson(Map<String, dynamic> map)
      : id = map['product_id'],
        image = map['thumb'],
        name = map['name'],
        description = map['description'],
        price = double.tryParse(map["price"]) ?? 0.0,
        special = double.tryParse(map["special"]) ?? 0.0,
        tax = double.tryParse(map["tax"]) ?? 0.0,
        minimum = double.tryParse(map["minimum"]) ?? 0.0,
        rating = map['rating'],
        link = map['href'];
}
