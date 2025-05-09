
import 'package:flutter/material.dart';

import '../../../data/model/service_model.dart';

class ServiceImage extends StatelessWidget {
  const ServiceImage({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          // Blurred image as placeholder
          Image.asset(
            'assets/img_placeholder.jpeg',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          // Network image with a loading indicator
          Positioned.fill(
            child: Image.network(
              service.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error), // Handle errors
            ),
          ),
        ],
      ),
    );
  }
}

