import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routing/app_routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
  
    bool isLoggedIn = false; 
    if (!isLoggedIn) {
      return const RouteSettings(name: AppRoutes.login);
    }
  }
}
