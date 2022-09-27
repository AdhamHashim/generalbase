import 'package:flutter/material.dart';
import '../../feature/screens/login/login_imports.dart';
import 'app_strings.dart';

class Routes {
  static const String splashRoute = "/";
  static const String intro = "/intro";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPassWordRoute = "/forgotPassWord";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      default:
        return undefineRoute();
    }
  }

  static Route<dynamic> undefineRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text(AppString.notRouteFound),
        ),
      ),
    );
  }
}
