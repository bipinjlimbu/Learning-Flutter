import 'package:first_app/models/product_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'EcomFlutter',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemCount: Product.products.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Image.asset(
                    Product.products[index].imagePath,
                    width: 400,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                  Text(
                    Product.products[index].title,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Product.products[index].price,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
