import 'package:weather/models/weather_model.dart';

class CitiesModel{
  final String cityName;
  final String lat;
  final String lon;
  WeatherResponse? weather;


  CitiesModel({required this.cityName, required this.lat, required this.lon,this.weather});

  factory CitiesModel.fromJson(Map<String, dynamic> json) {
    return CitiesModel(
      cityName: json['cityName'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}