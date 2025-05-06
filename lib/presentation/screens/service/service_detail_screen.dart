import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/service_controller.dart';
import 'service_form_screen.dart';

class ServiceDetailPage extends StatelessWidget {
  final controller = Get.find<ServiceController>();

  @override
  Widget build(BuildContext context) {
    final service = controller.selectedService.value;
    if (service == null) return Scaffold(body: Center(child: Text('No service selected')));

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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(service.imageUrl, height: 150, errorBuilder: (_, __, ___) => Icon(Icons.broken_image)),
            Text("Category: ${service.category}"),
            Text("Price: \$${service.price}"),
            Text("Available: ${service.availability ? 'Yes' : 'No'}"),
            Text("Duration: ${service.duration} min"),
            Text("Rating: ${service.rating}"),
          ],
        ),
      ),
    );
  }
}
