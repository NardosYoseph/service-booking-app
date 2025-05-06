import 'package:get/get.dart';
import '../../data/providers/service_api_provider.dart';
import '../../data/repositories/service_repository_impl.dart';
import '../controllers/service_controller.dart';

class ServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceApiProvider());
    Get.lazyPut(() => ServiceRepositoryImpl(Get.find()));
    Get.lazyPut(() => ServiceController(Get.find()));
  }
}
