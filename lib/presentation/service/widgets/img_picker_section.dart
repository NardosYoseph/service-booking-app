
import 'package:flutter/material.dart';

class ImagePickerSection extends StatelessWidget {
  final String? uploadedImageUrl;
  final VoidCallback onPickImage;

  const ImagePickerSection({
    this.uploadedImageUrl,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Image", style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        uploadedImageUrl != null
            ? Image.network(uploadedImageUrl!, height: 150)
            : Text("No image selected", style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
        SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: onPickImage,
          icon: Icon(Icons.image),
          label: Text("Pick Image", style: theme.textTheme.bodyMedium),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
