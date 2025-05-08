import 'package:get/get.dart';
import '../../core/util/snackbar_helper.dart';
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
      showSnackbar(title: 'Error', message: 'Failed to load services', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getService(String id) async {
    try {
      selectedService.value = await repository.getService(id) as Service;
    } catch (e) {
      showSnackbar(title: 'Error', message: 'Failed to get service', isError: true);
          }
  }

  Future<void> addService(Service service) async {
    try {
      print(service.toJson());
      await repository.addService(service.toEntity());
      fetchServices();
      Get.back();
      showSnackbar(title: 'Success', message: 'Service added successfully');
    } catch (e) {
      print(e);
    showSnackbar(title: 'Error', message: 'Failed to add service', isError: true);

    }
  }

  Future<void> updateService(String id, Service service) async {
    try {
      await repository.updateService(id, service.toEntity());
      fetchServices();
      Get.back();
       showSnackbar(title: 'Success', message: 'Service updated successfully');
    } catch (e) {
      print(e);
            showSnackbar(title: 'Error', message: 'Failed to update service', isError: true);

    }
  }

  Future<void> deleteService(String id) async {
    try {
      await repository.deleteService(id);
      fetchServices();
       showSnackbar(title: 'Success', message: 'Service deleted successfully');
    } catch (e) {
      showSnackbar(title: 'Error', message: 'Failed to delete service', isError: true);
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
