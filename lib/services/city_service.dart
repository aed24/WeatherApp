import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/cities_model.dart';

class CityService {
  List<CitiesModel> _cities = [];
  Future<void> loadCities() async {
    final String response = await rootBundle.loadString('assets/json/cities.json');
    final data = jsonDecode(response) as List;
    _cities = data.map((city) => CitiesModel.fromJson(city)).toList();
  }

  List<CitiesModel> get cities => _cities;
}