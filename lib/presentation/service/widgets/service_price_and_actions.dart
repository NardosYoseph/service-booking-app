import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/service_model.dart';
import '../../controllers/service_controller.dart';

class ServicePriceAndActions extends StatelessWidget {
  const ServicePriceAndActions({
    super.key,
    required this.service,
    required this.controller,
  });

  final Service service;
  final ServiceController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "\$${service.price}",
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () {
                // Show a confirmation dialog before deletion
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("delete_service".tr),
                    content: Text(
                        "delete_service_confirmation".tr),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back(); // Close the dialog
                        },
                        child: Text("cancel".tr),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Delete the service
                          await controller.deleteService(service.id);
                          Get.back(); // Close the dialog
                        },
                        child: Text("delete".tr),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
