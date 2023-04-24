import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final List<MenuOptions> menuOptions = [
    MenuOptions(route: 'home', screen: const HomeScreen()),
    MenuOptions(route: 'details', screen: const DetailsScreen())
  ];

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (var route in menuOptions) {
      appRoutes.addAll({route.route: (BuildContext context) => route.screen});
    }

    return appRoutes;
  }
}
