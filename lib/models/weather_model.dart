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
    final current = map['current'] as Map<String, dynamic>;
    final daily = map['daily'] as Map<String, dynamic>;

    final dates = daily['time'] as List<dynamic>;
    final codes = daily['weather_code'] as List<dynamic>;
    final maxTemps = daily['temperature_2m_max'] as List<dynamic>;
    final minTemps = daily['temperature_2m_min'] as List<dynamic>;

    final forecast = List<DailyWeather>.generate(
      dates.length,
      (index) => DailyWeather(
        date: DateTime.parse(dates[index].toString()),
        weatherCode: (codes[index] as num).toInt(),
        maxTemperature: maxTemps[index] as num,
        minTemperature: minTemps[index] as num,
      ),
    );

    return WeatherModel(
      temperature: current['temperature_2m'] as num,
      apparentTemperature: current['apparent_temperature'] as num,
      weatherCode: (current['weather_code'] as num).toInt(),
      humidity: (current['relative_humidity_2m'] as num).toInt(),
      windSpeed: current['wind_speed_10m'] as num,
      time: DateTime.tryParse(current['time'].toString()),
      dailyForecast: forecast,
    );
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
