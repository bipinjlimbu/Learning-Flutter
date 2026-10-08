import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text('This is the detail page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
