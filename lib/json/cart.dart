class Cart {
  String id;
  String productId;
  String productName;
  String model;
  String price;
  String total;
  String quantity;

  Cart.fromJson(Map<String, dynamic> map)
      : id = map['cart_id'],
        productId = map['product_id'],
        productName = map['name'],
        model = map['model'],
        quantity = map['quantity'],
        price = map['price'],
        total = map['total'];
}
