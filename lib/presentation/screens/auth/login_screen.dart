import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/routing/app_routes.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    print("Login button pressed");
    // if (usernameController.text == "admin" && passwordController.text == "1234") {
      Get.offAllNamed(AppRoutes.serviceList);
    // } else {
    //   Get.snackbar("Login Failed", "Invalid credentials");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: 'Username')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 16),
            ElevatedButton(onPressed: login, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
