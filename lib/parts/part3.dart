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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome to the BMI Calculator!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  var regex = RegExp(r'^\d+(\.\d+)?$');

                  if (value == null ||
                      value.isEmpty ||
                      !regex.hasMatch(value)) {
                    return 'Please enter a valid number for weight.';
                  }

                  if (double.parse(value) <= 0) {
                    return 'Weight must be greater than 0.';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter your weight (kg)',
                  hintText: 'e.g. 70',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  var regex = RegExp(r'^\d+(\.\d+)?$');

                  if (value == null ||
                      value.isEmpty ||
                      !regex.hasMatch(value)) {
                    return 'Please enter a valid number for height.';
                  }

                  if (double.parse(value) <= 0) {
                    return 'Height must be greater than 0.';
                  }

                  return null;
                },
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
                    if (_formKey.currentState!.validate()) {
                      final double weight = double.parse(
                        _weightController.text,
                      );

                      final double height = double.parse(
                        _heightController.text,
                      );

                      setState(() {
                        _bmi = weight / ((height / 100) * (height / 100));
                      });
                    }
                  },
                  child: const Text('Calculate BMI'),
                ),
              ),

              const SizedBox(height: 20),

              if (_bmi != null)
                Text(
                  'Your BMI is: ${_bmi!.toStringAsFixed(2)}\n'
                  'Category: ${getBMICategory(_bmi!)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else
                const Text(
                  'Your BMI will be displayed here.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

String getBMICategory(double bmi) {
  if (bmi < 18.5) {
    return 'Underweight';
  } else if (bmi < 24.9) {
    return 'Normal weight';
  } else if (bmi < 29.9) {
    return 'Overweight';
  } else {
    return 'Obese';
  }
}
