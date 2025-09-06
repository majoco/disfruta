class Product {
  final int id;
  final String name;
  final String description;
  final String price;
  final String image;
  final List<String> categories;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.categories,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],      
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      image: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['src']
          : '',
      categories: json['categories'] != null
          ? List<String>.from(
              json['categories'].map((c) => c['name']),
            )
          : [],
    );
  }
}
