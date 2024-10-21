import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/models/cities_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/viewmodel/details_view_model.dart';

import '../services/weather_service.dart';

class HomeViewModel extends ChangeNotifier{
  final getIt = GetIt.instance;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  String? errorMessage;
  List<CitiesModel> _homePageCities =[
    CitiesModel(cityName: "Istanbul", lat: "41.0136", lon: "28.9550"),
    CitiesModel(cityName: "Ankara", lat: "39.9300", lon: "32.8500"),
    CitiesModel(cityName: "İzmir", lat: "38.4200", lon: "27.1400"),
    CitiesModel(cityName: "Bursa", lat: "40.1833", lon: "29.0500"),
    CitiesModel(cityName: "Konya", lat: "37.8667", lon: "32.4833"),
  ];
  List<CitiesModel> get homePageCities => _homePageCities;

  Future<void> getHomeCities() async{
    for(var i = 0; i < _homePageCities.length; i++){
      _homePageCities[i].weather= await fetchWeather(_homePageCities[i].lat, _homePageCities[i].lon) as WeatherResponse?;
    }
    _isLoaded = true;
    notifyListeners();

  }
  Future<WeatherResponse?> fetchWeather(String lat, String lon) async {
    WeatherResponse? _weather;
    _isLoaded = false;
    errorMessage = null;

    try {
      final weatherService = getIt<WeatherService>();
      _weather = await weatherService.getWeather(lat,lon);
    } catch (e) {
      errorMessage = "Error fetching weather data";
    } finally {
      return _weather;
    }
  }


}