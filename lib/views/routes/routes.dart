import 'package:flutter/material.dart';

import '../home_view.dart';
import '../login_view.dart';

/// Gerencia rotas
class Routes {
  ///Gerencia as rotas
  static Route<dynamic> createRoutes(RouteSettings routes) {
    switch (routes.name) {
      case ' /home':
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Text('Página não encontrada'),
          ),
        );
    }
  }
}
