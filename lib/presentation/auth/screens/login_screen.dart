import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/util/routing/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    Get.offAllNamed(AppRoutes.serviceList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Welcome Back 👋",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: usernameController,
                label: "Username",
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                label: "Password",
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              CustomButton(text: "Login", onPressed: login),
            ],
          ),
        ),
      ),
    );
  }
}
