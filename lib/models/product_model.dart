class Product {
  final String id;
  final String title;
  final String imagePath;
  final String price;

  Product({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.price,
  });

  static List<Product> products = [
    Product(
      id: '1',
      title: 'Yuvaraajaa Khotri',
      imagePath: 'assets/product1.jpg',
      price: '₹ 10',
    ),
  ];
}
