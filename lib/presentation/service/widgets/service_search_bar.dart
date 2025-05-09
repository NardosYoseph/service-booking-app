import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/service_controller.dart';

class ServiceSearchBar extends StatelessWidget {
  const ServiceSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceController>();

    return TextField(
      decoration: InputDecoration(
        hintText: "search_by_name".tr,
        prefixIcon: const Icon(Icons.search),
      ),
      onChanged: controller.filterServices,
    );
  }
}
