import 'package:flutter/material.dart';

class Part1 extends StatelessWidget {
  const Part1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Workshop - Part 1',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Container(color: Colors.red, height: 100)),

              Expanded(child: Container(color: Colors.green, height: 100)),

              Expanded(child: Container(color: Colors.pink, height: 100)),
            ],
          ),

          const SizedBox(height: 20),

          Container(height: 100, width: double.infinity, color: Colors.yellow),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(color: Colors.blue, height: 100, width: 100),

              Container(color: Colors.orange, height: 100, width: 100),

              Container(color: Colors.purple, height: 100, width: 100),
            ],
          ),

          const SizedBox(height: 20),

          Container(height: 100, width: double.infinity, color: Colors.grey),
        ],
      ),
    );
  }
}
