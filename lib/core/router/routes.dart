import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_demo/core/router/route_constants.dart';
import 'package:login_demo/feature/presentation/dashboard/dashboard_screen.dart';
import 'package:login_demo/feature/presentation/splashscreen/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  ///routes
  static const String initial = initialRoute;
  static const String dashboard = dashboardRoute;
  static const String drinksListingAsPerCategory =
      drinksListingAsPerCategoryRoute;
  static const String drinkDetail = drinkDetailsRoute;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case initial:
        return CupertinoPageRoute(
            settings: const RouteSettings(name: initial),
            builder: (BuildContext context) => const SplashScreen());
      case dashboardRoute:
        return CupertinoPageRoute(
            builder: (BuildContext context) => const DashboardScreen());
      case drinksListingAsPerCategoryRoute:
      case drinkDetailsRoute:
      default:
        return CupertinoPageRoute(
            builder: (BuildContext context) => const Scaffold(
                  body: Center(
                    child: Text("No Route Found"),
                  ),
                ));
    }
  }
}
