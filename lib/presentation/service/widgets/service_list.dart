import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/service_controller.dart';
import 'service_list_item.dart';

class ServiceList extends StatelessWidget {
  final controller = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final services = controller.filteredServices.isNotEmpty
          ? controller.filteredServices
          : controller.services;

      if (services.isEmpty) {
        return Center(child: Text("no_services_found".tr));
      }

      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: services.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          return ServiceListItem(service: services[index]);
        },
      );
    });
  }
}
