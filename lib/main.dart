import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/util/routing/app_pages.dart';
import 'core/util/routing/app_routes.dart';
import 'data/model/service_model.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ServiceAdapter());
  await Hive.openBox<Service>('services');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Service Manager',
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
