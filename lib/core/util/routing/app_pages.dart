import 'package:get/get.dart';
import '../../../presentation/bindings/service_binding.dart';
import '../../../presentation/middleware/auth_middleware.dart';
import '../../../presentation/auth/screens/login_screen.dart';
import '../../../presentation/service/screens/service_detail_screen.dart';
import '../../../presentation/service/screens/service_form_screen.dart';
import '../../../presentation/service/screens/service_list_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => LoginPage()),
    GetPage(
      name: AppRoutes.serviceList,
      page: () => ServiceListPage(),
      binding: ServiceBinding(),
      // middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoutes.serviceForm,
      page: () => ServiceFormPage(),
      binding: ServiceBinding(),
    ),
    GetPage(
      name:AppRoutes.serviceDetail,
      page: () => ServiceDetailPage(),
      binding: ServiceBinding(),
    ),
  ];
}
