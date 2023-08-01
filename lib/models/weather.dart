import 'package:equatable/equatable.dart';
enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}
class Weather extends Equatable {
  final WeatherCondition weatherCondition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;
  //constructor
  const Weather({
    required this.weatherCondition,
    required this.formattedCondition,
    required this.minTemp,
    required this.temp,
    required this.maxTemp,
    required this.locationId,
    required this.created,
    required this.lastUpdated,
    required this.location,
  });
  @override
  // TODO: implement props
  List<Object> get props => [
    weatherCondition,
    formattedCondition,
    minTemp,
    temp,
    maxTemp,
    locationId,
    created,
    lastUpdated,
    location,
  ];
  factory Weather.fromJson(dynamic jsonObject) {
    if (jsonObject == null) {
      throw Exception('Invalid API response: Data is null');
    }

    final consolidatedWeather = jsonObject['list'] as List<dynamic>;
    if (consolidatedWeather.isEmpty) {
      throw Exception('Invalid API response: Weather data not found');
    }

    final weatherData = consolidatedWeather[0];
    if (weatherData == null) {
      throw Exception('Invalid API response: Weather data is null');
    }

    return Weather(
      weatherCondition: _mapStringToWeatherCondition(weatherData['weather'][0]['main']) ?? WeatherCondition.unknown,
      formattedCondition: weatherData['weather'][0]['description'] ?? '',
      minTemp: (weatherData['main']['temp_min'] as double?) ?? 0.0,
      temp: (weatherData['main']['temp'] as double?) ?? 0.0,
      maxTemp: (weatherData['main']['temp_max'] as double?) ?? 0.0,
      locationId: jsonObject['id'] as int? ?? 0,
      created: '',
      lastUpdated: DateTime.now(),
      location: jsonObject['name'] ?? '',
    );
  }




  static WeatherCondition? _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'sn': WeatherCondition.snow,
      'sl': WeatherCondition.sleet,
      'h': WeatherCondition.hail,
      't': WeatherCondition.thunderstorm,
      'hr': WeatherCondition.heavyRain,
      'lr': WeatherCondition.lightRain,
      's': WeatherCondition.showers,
      'hc': WeatherCondition.heavyCloud,
      'lc': WeatherCondition.lightCloud,
      'c': WeatherCondition.clear,
      'unknown': WeatherCondition.unknown
    };
    return map[inputString];
  }

}