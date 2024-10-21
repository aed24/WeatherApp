import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/cities_model.dart';
import 'package:weather/services/city_service.dart';
import 'package:weather/viewmodel/details_view_model.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class DiscoverViewModel extends ChangeNotifier{
  late CityService _cityService;
  final getIt = GetIt.instance;
  List<CitiesModel> _historyList= [];
  List<CitiesModel> get historyList => _historyList;
  CitiesModel? selectedCity;
  WeatherResponse? selectedWeather;
  List<CitiesModel> _cityList =[];
  List<CitiesModel> get cityList => _cityList;
  String? errorMessage;

  Future<void> loadSavedHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('HistoryLength') == false){
      prefs.setInt("HistoryLength", 0);
    }
    else if(_historyList.length== 0){
      int length = prefs.getInt("HistoryLength") ?? 0;
      for(var i = 1; i < length+1; i++){
        String lat = prefs.getString("Historylat$i")?? "a";
        String lon = prefs.getString("Historylon$i")?? "a";
        String name = prefs.getString("Historyname$i")?? "a";
        _historyList.add(CitiesModel(cityName: name, lat: lat, lon: lon));
      }
        
    }
    notifyListeners();
  }
  Future<void> saveHistory(CitiesModel city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int length = prefs.getInt("HistoryLength") ?? 0;
    length = length+1;
    await prefs.setInt('HistoryLength', length);
    await prefs.setString('Historyname$length', city.cityName);
    await prefs.setString('Historylat$length', city.lat);
    await prefs.setString('Historylon$length', city.lon);
    _historyList.add(CitiesModel(cityName: city.cityName, lat: city.lat, lon: city.lon));

  }

  Future<void> loadCities() async {
    _cityService = GetIt.I<CityService>();
    await _cityService.loadCities();
    await loadSavedHistory();
    _cityList = _cityService.cities;
    notifyListeners();
  }
  Future<void> setCitiesDetails(CitiesModel city, BuildContext context) async {
    try {
      selectedWeather = await fetchWeather(city.lat.toString(), city.lon.toString());

      final detailsViewModel = Provider.of<DetailsViewModel>(context, listen: false);
      detailsViewModel.updateCity(CitiesModel(
          cityName: city.cityName,
          lat: city.lat.toString(),
          lon: city.lon.toString(),
          weather: selectedWeather
      ));

      notifyListeners();
    } catch (e) {
      print('Hata oluştu: $e');
      // Hata durumunda kullanıcıya bilgi verebilirsiniz
    }
  }

  Future<WeatherResponse?> fetchWeather(String lat, String lon) async {
    WeatherResponse? _weather;
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