import 'package:flutter/material.dart';

import '../models/product_model.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.blue,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(16.0),
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
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text(
              product.price,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: Colors.yellow),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
