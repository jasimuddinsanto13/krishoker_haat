class Product {
  final int id;
  final String name;
  final String category;
  final String description;
  final double price;
  final String imageUrl;
  final String minQuantity;
  final double deliveryCharge;
  final String deliveryTime;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.minQuantity,
    required this.deliveryCharge,
    required this.deliveryTime,
  });
}
