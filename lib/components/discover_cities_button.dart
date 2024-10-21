import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/cities_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/viewmodel/details_view_model.dart';
import 'package:weather/viewmodel/discover_view_model.dart';

import '../router/app_router.dart';

class DiscoverCitiesButton extends StatelessWidget {
  final CitiesModel city;
  const DiscoverCitiesButton(
      {Key? key, required this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width *0.8,
        child: InkWell(
          onTap: () async {
            final discoverViewModel = Provider.of<DiscoverViewModel>(context, listen: false);
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Center(child: CircularProgressIndicator());
              },
            );

            try {
              await discoverViewModel.setCitiesDetails(city, context);
              await discoverViewModel.saveHistory(city);
              Navigator.of(context).pop();
              context.router.push(DetailsRoute());
            } catch (e) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Veri yüklenirken bir hata oluştu')),
              );
            }
          },
          borderRadius: BorderRadius.circular(15),
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
                        ">",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
