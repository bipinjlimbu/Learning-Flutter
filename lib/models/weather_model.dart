class WeatherModel {
  final num temperature;
  final num apparentTemperature;
  final int weatherCode;
  final int humidity;
  final num windSpeed;
  final DateTime? time;
  final List<DailyWeather> dailyForecast;

  WeatherModel({
    required this.temperature,
    required this.apparentTemperature,
    required this.weatherCode,
    required this.humidity,
    required this.windSpeed,
    required this.time,
    required this.dailyForecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> map) {
    final current = Map<String, dynamic>.from(map['current'] ?? {});
    final daily = Map<String, dynamic>.from(map['daily'] ?? {});

    final dates = daily['time'] as List? ?? [];
    final codes = daily['weather_code'] as List? ?? [];
    final maxTemps = daily['temperature_2m_max'] as List? ?? [];
    final minTemps = daily['temperature_2m_min'] as List? ?? [];

    final forecast = <DailyWeather>[];

    for (int i = 0; i < dates.length; i++) {
      if (i >= codes.length || i >= maxTemps.length || i >= minTemps.length) {
        break;
      }

      final date = DateTime.tryParse(dates[i].toString());
      final code = codes[i];
      final maxTemp = maxTemps[i];
      final minTemp = minTemps[i];

      if (date == null || code is! num || maxTemp is! num || minTemp is! num) {
        continue;
      }

      forecast.add(
        DailyWeather(
          date: date,
          weatherCode: code.toInt(),
          maxTemperature: maxTemp,
          minTemperature: minTemp,
        ),
      );
    }

    return WeatherModel(
      temperature: _number(current['temperature_2m']),
      apparentTemperature: _number(current['apparent_temperature']),
      weatherCode: _number(current['weather_code']).toInt(),
      humidity: _number(current['relative_humidity_2m']).toInt(),
      windSpeed: _number(current['wind_speed_10m']),
      time: DateTime.tryParse(current['time']?.toString() ?? ''),
      dailyForecast: forecast,
    );
  }

  static num _number(dynamic value) {
    if (value is num) return value;
    return 0;
  }
}

class DailyWeather {
  final DateTime date;
  final int weatherCode;
  final num maxTemperature;
  final num minTemperature;

  DailyWeather({
    required this.date,
    required this.weatherCode,
    required this.maxTemperature,
    required this.minTemperature,
  });
}
