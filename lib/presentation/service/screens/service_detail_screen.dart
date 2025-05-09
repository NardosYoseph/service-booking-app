import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/service_controller.dart';
import '../widgets/service_detail_info_row.dart';
import 'service_form_screen.dart';

class ServiceDetailPage extends StatelessWidget {
  final controller = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    final service = controller.selectedService.value;
    if (service == null) return Scaffold(body: Center(child: Text('no_service_selected'.tr)));

    return Scaffold(
      appBar: AppBar(
        title: Text(service.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Get.to(() => ServiceFormPage(service: service)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                service.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(Icons.broken_image, size: 100),
              ),
            ),
            SizedBox(height: 16),

          InfoRow(label: 'category'.tr, value: service.category),
          InfoRow(label: 'price'.tr, value: "\$${service.price.toStringAsFixed(2)}"),
          InfoRow(label: 'available'.tr, value: service.availability ? 'yes'.tr : 'no'.tr,),
           InfoRow(label: 'duration'.tr, value: "${service.duration} min"),
            InfoRow(label: 'rating'.tr, value: service.rating.toString()),

          ],
        ),
      ),
    );
  }

  }
