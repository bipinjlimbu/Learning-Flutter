import 'package:first_app/models/product_model.dart';
import 'package:flutter/material.dart';

import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bech Denge', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: Product.products.length,
        itemBuilder: (context, index) {
          Product product = Product.products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(product: product),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.blue,
                child: Column(
                  children: [
                    Image.asset(
                      product.imagePath,
                      width: 400,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(product.price, style: const TextStyle(fontSize: 25)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
