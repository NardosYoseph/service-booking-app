import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/util/routing/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Simulated check
    // bool isLoggedIn = true; // Set logic here if you add persistent login
    // if (!isLoggedIn) {
      return const RouteSettings(name: AppRoutes.login);
    // }
    // return null;
  }
}
