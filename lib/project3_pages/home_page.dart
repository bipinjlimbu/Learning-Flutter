import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../models/weather_code.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherModel> weatherFuture;

  @override
  void initState() {
    super.initState();
    weatherFuture = fetchWeatherData();
  }

  Future<WeatherModel> fetchWeatherData() async {
    try {
      final dio = Dio();

      final response = await dio.get(
        'https://api.open-meteo.com/v1/forecast?latitude=27.7172&longitude=85.3240&current=temperature_2m,relative_humidity_2m,apparent_temperature,weather_code,wind_speed_10m&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto',
      );

      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      throw e.message ?? 'An error occurred while fetching weather data.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: FutureBuilder<WeatherModel>(
        future: weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final weather = snapshot.data!;

            final weatherDescription =
                kWeatherCode[weather.weatherCode.toString()] ??
                'Unknown weather';

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Apparent Temperature: '
                    '${weather.apparentTemperature}°C',
                  ),
                  const SizedBox(height: 8),
                  Text('Weather: $weatherDescription'),
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
