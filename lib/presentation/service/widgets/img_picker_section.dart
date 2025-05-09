import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePickerSection extends StatefulWidget {
  final String? uploadedImageUrl;
  final VoidCallback onPickImage;

  const ImagePickerSection({
    this.uploadedImageUrl,
    required this.onPickImage,
  });

  @override
  _ImagePickerSectionState createState() => _ImagePickerSectionState();
}

class _ImagePickerSectionState extends State<ImagePickerSection> {
  bool _isLoading = false;  // Track loading state

  void _handleImagePick() async {
    setState(() {
      _isLoading = true;  // Start loading
    });

    // Simulate image fetching or processing (for example, picking or uploading image)
    await Future.delayed(Duration(seconds: 2));  // Simulate a delay for image load

    widget.onPickImage();  // Trigger the parent callback (to update the image)

    setState(() {
      _isLoading = false;  // Stop loading once the image is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("image".tr, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        widget.uploadedImageUrl != null
            ? _isLoading
                ? Center(child: CircularProgressIndicator())  // Show loading while image is being fetched
                : Image.network(widget.uploadedImageUrl!, height: 150)
            : Text("no_image_selected".tr, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
        SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _handleImagePick,  // Use the new image pick handler
          icon: Icon(Icons.image, color: theme.colorScheme.primary),
          label: Text("pick_image".tr, style: theme.textTheme.bodyMedium),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.surface,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
