import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/util/routing/app_routes.dart';
import '../../../data/model/service_model.dart';
import '../../controllers/service_controller.dart';

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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(service.imageUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service.category,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                  ),
                ],
              ),
            ),
            Text(
              "\$${service.price}",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}
