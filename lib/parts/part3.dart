import 'package:flutter/material.dart';

class Part3 extends StatelessWidget {
  const Part3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Workshop - Part 3',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double? _bmi;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Workshop - Part 3',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(37.0),
        color: Colors.cyanAccent,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to the BMI Calculator!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter your weight (kg)',
                hintText: 'e.g. 70',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter your height (cm)',
                hintText: 'e.g. 175',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  final double weight =
                      double.tryParse(_weightController.text) ?? 0;
                  final double height =
                      double.tryParse(_heightController.text) ?? 0;

                  if (weight > 0 && height > 0) {
                    setState(() {
                      _bmi = weight / ((height / 100) * (height / 100));
                    });
                  } else {
                    setState(() {
                      _bmi = null;
                    });
                  }
                },
                child: Text('Calculate BMI'),
              ),
            ),
            const SizedBox(height: 20),
            if (_bmi != null)
              Text(
                'Your BMI is: ${_bmi!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            else
              Text(
                'Your BMI will be displayed here.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            if (_bmi != null)
              Text(
                _bmi! < 18.5
                    ? 'You are underweight.'
                    : _bmi! < 24.9
                    ? 'You have a normal weight.'
                    : _bmi! < 29.9
                    ? 'You are overweight.'
                    : 'You are obese.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
