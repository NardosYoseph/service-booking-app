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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Image with better styling and rounded corners
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

            // Service Information: Styled and with spacing for a clean look
            _buildInfoRow(context,"Category:", service.category),
            _buildInfoRow(context,"Price:", "\$${service.price.toStringAsFixed(2)}"),
            _buildInfoRow(context,"Available:", service.availability ? 'Yes' : 'No'),
            _buildInfoRow(context,"Duration:", "${service.duration} min"),
            _buildInfoRow(context,"Rating:", service.rating.toString()),
          ],
        ),
      ),
    );
  }

  // Helper method to build styled info rows
  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
