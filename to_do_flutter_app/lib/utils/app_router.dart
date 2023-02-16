import 'package:flutter/material.dart';
import 'package:to_do_flutter_app/screens/deleted_screen.dart';
import 'package:to_do_flutter_app/screens/tabs_screen.dart';
import 'package:to_do_flutter_app/screens/pending_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case DeletedScreen.id:
        return MaterialPageRoute(
          builder: (_) => const DeletedScreen()
        );
      case TabsScreen.id:
        return MaterialPageRoute(
          builder: (_) => const TabsScreen()
        );

      default:
        return null;
    }
  }
}