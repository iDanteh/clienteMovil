class Product {
  final int id;
  final String name;
  final String description;
  final String price; // Ajuste para que price sea un String
  final int stock;
  final int categoryId; // Cambio a categoryId
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.categoryId,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'],
      description: json['description'],
      price: json['price'].toString(), // Conversión a String
      stock: int.tryParse(json['stock'].toString()) ?? 0,
      categoryId: int.tryParse(json['category_id'].toString()) ?? 0,
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'category_id': categoryId,
      'image_url': imageUrl,
    };
  }
}
