class ResponseModel {
  final String status;
  final String message;
  final List<Product> products;

  ResponseModel({
    required this.status,
    required this.message,
    required this.products,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'],
      message: json['message'],
      products: (json['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
    );
  }
}

class Product {
  final int id;
  final String title;
  final String image;
  final double price;
  final String description;
  final String brand;
  final String model;
  final String color;
  final String category;
  final int discount;
  final bool? popular;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.brand,
    required this.model,
    required this.color,
    required this.category,
    required this.discount,
    this.popular,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0, // Default to 0 if null
      title: json['title'] ?? 'Unknown', // Default to 'Unknown' if null
      image: json['image'] ?? '', // Default to an empty string if null
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // Handle null for price
      description: json['description'] ?? 'No description', // Default description
      brand: json['brand'] ?? 'No brand', // Default brand
      model: json['model'] ?? 'No model', // Default model
      color: json['color'] ?? 'No color', // Default color
      category: json['category'] ?? 'No category', // Default category
      discount: json['discount'] ?? 0, // Default discount to 0 if null
      popular: json['popular'] ?? false, // Default popular to false if null
    );
  }

  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(
  //       id: json['id'],
  //       title: json['title'],
  //       image: json['image'],
  //       price: (json['price'] as num).toDouble(),
  //       description: json['description'],
  //       brand: json['brand'],
  //       model: json['model'],
  //       color: json['color'],
  //       category: json['category'],
  //       discount: json['discount'],
  //       popular: json['popular'],
  //       );
  //   }
}