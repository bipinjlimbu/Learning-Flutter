class WeatherModel {
  final num apparentTemperature;
  final int weatherCode;

  WeatherModel({required this.apparentTemperature, required this.weatherCode});

  factory WeatherModel.fromJson(Map<String, dynamic> map) {
    return WeatherModel(
      apparentTemperature: map['current']['apparent_temperature'] as num,
      weatherCode: map['current']['weather_code'] as int,
    );
  }
}
