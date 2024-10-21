import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/models/weather_model.dart';

class WeatherService {

  Future<WeatherResponse> getWeather(String lat, String lon) async {
    final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=a5dbc123cf685a8b35e119331f83d8cb");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return WeatherResponse.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}