import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/components/home_cities_button.dart';
import 'package:weather/router/app_router.dart';
import 'package:weather/viewmodel/discover_view_model.dart';
import 'package:weather/viewmodel/home_view_model.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () async{
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // Tüm depolanan verileri temizler.
              context.router.push(ProfileRoute());
            },
          ),

        ],
      ),
      body: Column(
        children: [
          Consumer<HomeViewModel>(
            builder: (context, viewModel, child) {
              return Center(
                child: Column(
                  children: [
                    for( var a in viewModel.homePageCities)
                      if(a.weather != null)
                        HomeCitiesButton(city: a,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.8,
                      child: InkWell(
                        onTap: () async{
                          final discoverViewModel = Provider.of<DiscoverViewModel>(context, listen:  false);
                          discoverViewModel.loadCities();
                          context.router.push(DiscoverRoute());
                        },
                        borderRadius: BorderRadius.circular(15), // Matches the card's shape
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Search Another City")
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              );
            },)
        ],
      )

    );

  }
}
