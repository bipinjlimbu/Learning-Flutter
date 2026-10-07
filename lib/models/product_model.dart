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
    Product(
      id: '2',
      title: 'Thaane Waala',
      imagePath: 'assets/product2.jpg',
      price: '₹ 20',
    ),
    Product(
      id: '3',
      title: 'Hum Hain Chappri',
      imagePath: 'assets/product3.JPG',
      price: '₹ 30',
    ),
    Product(
      id: '4',
      title: 'Kigga Boi',
      imagePath: 'assets/product4.JPG',
      price: '₹ 40',
    ),
  ];
}
