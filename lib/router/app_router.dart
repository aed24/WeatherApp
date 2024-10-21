import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/main.dart';
import '../view/details_view.dart';
import '../view/discover_view.dart';
import '../view/home_view.dart';
import '../view/profile_view.dart';
import '../view/splash_view.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page,initial:true ),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: DetailsRoute.page),
    AutoRoute(page: DiscoverRoute.page),
    AutoRoute(page: ProfileRoute.page)

  ];
}

final router = AppRouter();