import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:weather/router/app_router.dart';
import 'package:weather/services/city_service.dart';
import 'package:weather/services/weather_service.dart';
import 'package:weather/viewmodel/details_view_model.dart';
import 'package:weather/viewmodel/discover_view_model.dart';
import 'package:weather/viewmodel/home_view_model.dart';
import 'package:weather/viewmodel/profile_view_model.dart';
void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel() ),
        ChangeNotifierProvider(create: (_) => DetailsViewModel() ),
        ChangeNotifierProvider(create: (_) => DiscoverViewModel() ),
      ],
      child: MyApp(),
    ),
  );
}
final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => WeatherService());
  getIt.registerSingleton<CityService>(CityService());


}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerDelegate: router.delegate(),
      routeInformationParser: router.defaultRouteParser(),
    );
  }
}
