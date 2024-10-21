import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/viewmodel/details_view_model.dart';


@RoutePage()
class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
        ),
        body: Column(
          children: [
            Consumer<DetailsViewModel>(
              builder: (context, viewModel, child) {
                return Center(
                  child: Column(
                    children: [
                      Text(viewModel.cityDetails!.cityName, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: viewModel.cityDetails!.weather != null ?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text( "Tempeture: " + (viewModel.cityDetails!.weather!.main.temp.toInt() - 273).toString() + "°C",textAlign: TextAlign.left,),
                              Text( "Fells Tempeture: " + (viewModel.cityDetails!.weather!.main.feelsLike.toInt() - 273).toString() + "°C"),
                              Text( "Weather: " + viewModel.cityDetails!.weather!.weather[0].main),
                              Text( "Weather Description: " + viewModel.cityDetails!.weather!.weather[0].description),

                            ],
                          ):Text("Information about the city is not available ")
                        ),
                      )
                    ],
                  ),
                );
              },)
          ],
        )

    );
  }
}
