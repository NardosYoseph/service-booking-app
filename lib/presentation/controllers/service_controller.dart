import 'package:get/get.dart';
import '../../data/model/service_model.dart';
import '../../data/repositories/service_repository_impl.dart';

class ServiceController extends GetxController {
  final ServiceRepositoryImpl repository;

  ServiceController(this.repository);

  var services = <Service>[].obs;
  var isLoading = false.obs;
  var selectedService = Rxn<Service>();
var filteredServices = <Service>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchServices();
  }

  Future<void> fetchServices() async {
    isLoading.value = true;
    try {
      final data = await repository.getServices();
      services.value = data.map((e) => Service.fromEntity(e)).toList(); 
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to load services');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getService(String id) async {
    try {
      selectedService.value = await repository.getService(id) as Service;
    } catch (e) {
      Get.snackbar('Error', 'Failed to get service');
    }
  }

  Future<void> addService(Service service) async {
    try {
      print(service.toJson());
      await repository.addService(service.toEntity());
      fetchServices();
      Get.back();
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to add service');
    }
  }

  Future<void> updateService(String id, Service service) async {
    try {
      await repository.updateService(id, service.toEntity());
      fetchServices();
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update service');
    }
  }

  Future<void> deleteService(String id) async {
    try {
      await repository.deleteService(id);
      fetchServices();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete service');
    }
  }

void filterServices(String query) {
  if (query.isEmpty) {
    filteredServices.assignAll(services);
  } else {
    final lowerQuery = query.toLowerCase();
    filteredServices.assignAll(
      services.where((s) =>
          s.name.toLowerCase().contains(lowerQuery) ||
          s.category.toLowerCase().contains(lowerQuery) ||
          s.rating.toString().contains(lowerQuery)),
    );
  }
}


}
