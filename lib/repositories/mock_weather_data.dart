import 'package:weatherapp/models/weather.dart';

class MockWeatherData {
  static List<Weather> weatherData = [
    Weather(
      weatherCondition: WeatherCondition.clear,
      formattedCondition: 'Clear',
      minTemp: 15.0,
      temp: 20.0,
      maxTemp: 25.0,
      locationId: 1,
      created: '2023-07-28',
      lastUpdated: DateTime.now(),
      location: 'Chicago',
    ),
    // Add more mock data for other cities or conditions as needed
  ];
}
