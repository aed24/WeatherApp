import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/cities_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/viewmodel/details_view_model.dart';

import '../router/app_router.dart';

class HomeCitiesButton extends StatelessWidget {
  final CitiesModel city;
  const HomeCitiesButton(
      {Key? key, required this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width *0.8,
        child: InkWell(
          onTap: () async{
            final detailsViewModel = Provider.of<DetailsViewModel>(context, listen:  false);
            detailsViewModel.updateCity(city);
            context.router.push(DetailsRoute());
          },
          borderRadius: BorderRadius.circular(15), // Matches the card's shape
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        city.cityName,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        (city.weather!.main.temp.toInt() - 273).toString() + "°C",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(city.weather!.weather[0].main,  textAlign: TextAlign.end)
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
