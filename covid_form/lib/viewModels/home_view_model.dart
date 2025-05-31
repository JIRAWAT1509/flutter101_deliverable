import 'package:flutter/material.dart';
import 'package:covid_form/models/home_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<NavigationItem> get navigationItems => [
    NavigationItem(
      title: 'Covid Form',
      icon: Icons.calendar_today,
      route: 'covid_form',
    ),
    NavigationItem(
      title: 'Patients List',
      icon: Icons.people,
      route: 'patients_list',
    ),
  ];

  String getTitleByRoute(String route) {
    final item = navigationItems.firstWhere(
      (item) => item.route == route,
      orElse:
          () => NavigationItem(title: 'Unknown', icon: Icons.error, route: ''),
    );
    return item.title;
  }
}
