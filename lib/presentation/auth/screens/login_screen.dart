import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/routing/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final List<Locale> supportedLocales = const [
    Locale('en', 'US'),
    Locale('am', 'ET'),
  ];

  final Map<String, String> languageNames = {
    'en': 'English',
    'am': 'አማርኛ',
  };

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton<Locale>(
                    value: Get.locale,
                    underline: SizedBox(),
                    icon: const Icon(Icons.arrow_drop_down),
                    items: supportedLocales.map((locale) {
                      return DropdownMenuItem(
                        value: locale,
                        child: Text(languageNames[locale.languageCode] ?? ''),
                      );
                    }).toList(),
                    onChanged: (locale) {
  if (locale != null) {
    Get.updateLocale(locale);
    final box = GetStorage();
    box.write('lang', locale.languageCode); // Save to local storage
  }
},

                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'welcome_back'.tr,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: usernameController,
                label: 'username'.tr,
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                label: 'password'.tr,
                icon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'login'.tr,
                onPressed: login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
