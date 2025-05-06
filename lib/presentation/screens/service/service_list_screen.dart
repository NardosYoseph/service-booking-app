// lib/presentation/pages/service_list_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/util/routing/app_routes.dart';
import '../../controllers/service_controller.dart';

class ServiceListPage extends StatelessWidget {
  final ServiceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Get.toNamed(AppRoutes.serviceForm),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by name, category, or rating",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => controller.filterServices(value),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final services = controller.filteredServices;

              if (services.isEmpty) {
                return const Center(child: Text("No services found"));
              }

              return ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(service.imageUrl),
                    ),
                    title: Text(service.name),
                    subtitle: Text("${service.category} • \$${service.price}"),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      controller.selectedService.value = service;
                      Get.toNamed(AppRoutes.serviceDetail);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
