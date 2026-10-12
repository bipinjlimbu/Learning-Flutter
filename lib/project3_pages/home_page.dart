import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/weather_model.dart';

class HomePage extends StatefulWidget {
  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<WeatherModel> fetchWeatherData() async {
    try {
      Dio dio = Dio();
      final response = await dio.get(
        'https://api.open-meteo.com/v1/forecast?latitude=27.7172&longitude=85.3240&current=temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto',
      );

      final weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      throw e.message ?? 'An error occurred while fetching weather data.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: FutureBuilder<WeatherModel>(
        future: fetchWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final weather = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Apparent Temperature: ${weather.apparentTemperature}°C',
                  ),
                  Text('Weather Code: ${weather.weatherCode}'),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
