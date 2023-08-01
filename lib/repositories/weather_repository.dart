import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/models/weather.dart';

const baseUrl = 'http://api.openweathermap.org/data/2.5';
const apiKey = '8f33b7d9903f352b88384705a30a3de3'; // Replace this with your actual API key from OpenWeatherMap

Uri locationUrl(String city) {
  final encodedCity = Uri.encodeComponent(city);
  return Uri.parse('$baseUrl/weather?q=$encodedCity&appid=$apiKey');
}

Uri weatherUrl(int locationId) {
  return Uri.parse('$baseUrl/forecast?id=$locationId&appid=$apiKey');
}

class WeatherRepository {
  final http.Client httpClient;

  WeatherRepository({required this.httpClient});

  Future<int?> getLocationIdFromCity(String city) async {
    final response = await this.httpClient.get(locationUrl(city));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('id')) {
        return data['id'] as int?;
      }
    }
    return null;
  }

  // LocationId => Weather
  Future<Weather> fetchWeather(int locationId) async {
    final response = await this.httpClient.get(weatherUrl(locationId));
    print('Weather API Response: ${response.statusCode} - ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data); // Assuming you have a fromJson method in your Weather model
    } else {
      throw Exception('Error getting weather from locationId: $locationId');
    }
  }

  Future<Weather> getWeatherFromCity(String city) async {
    final int? locationId = await getLocationIdFromCity(city);
    if (locationId != null) {
      return fetchWeather(locationId);
    } else {
      throw Exception('Location ID not found for city: $city');
    }
  }
}
