import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routing/app_routes.dart';
import '../../../data/model/service_model.dart';
import '../../controllers/service_controller.dart';
import 'service_image.dart';
import 'service_info.dart';
import 'service_price_and_actions.dart';

class ServiceListItem extends StatelessWidget {
  final Service service;

  const ServiceListItem({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ServiceController>();

    return InkWell(
      onTap: () {
        controller.selectedService.value = service;
        Get.toNamed(AppRoutes.serviceDetail);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ServiceImage(service: service),
            const SizedBox(width: 16),
            ServiceInfo(service: service),
            ServicePriceAndActions(service: service, controller: controller),
          ],
        ),
      ),
    );
  }
}
