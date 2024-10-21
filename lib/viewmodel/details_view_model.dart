import 'package:flutter/cupertino.dart';
import 'package:weather/models/cities_model.dart';

class DetailsViewModel extends ChangeNotifier{
   CitiesModel? _cityDetails;
   CitiesModel? get cityDetails => _cityDetails;


   void updateCity(CitiesModel city){
      _cityDetails = city;
      notifyListeners();

   }




}