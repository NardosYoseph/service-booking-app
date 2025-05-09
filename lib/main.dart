import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/localizations/app_translation.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_pages.dart';
import 'core/routing/app_routes.dart';
import 'data/model/service_model.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ServiceAdapter());
  await Hive.openBox<Service>('services');
await dotenv.load();
 await GetStorage.init();
  final box = GetStorage();

  // Load stored locale
  final langCode = box.read('lang') ?? 'en';
  final countryCode = langCode == 'am' ? 'ET' : 'US';

  runApp(MyApp(locale: Locale(langCode, countryCode)));
}

class MyApp extends StatelessWidget {
  final Locale locale;

  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: locale,
      translations: AppTranslations(),
      fallbackLocale: const Locale('en', 'US'),
      // supportedLocales: const [
      //   Locale('en', 'US'),
      //   Locale('am', 'ET'),
      // ],
      title: 'Service Manager',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
