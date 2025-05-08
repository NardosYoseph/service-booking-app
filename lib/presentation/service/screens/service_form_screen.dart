import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/model/service_model.dart';
import '../../../data/services/image_uploader.dart';
import '../../controllers/service_controller.dart';

class ServiceFormPage extends StatefulWidget {
  final Service? service;

  ServiceFormPage({this.service});

  @override
  _ServiceFormPageState createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController name, category, price, duration, rating;
  bool available = true;

  final controller = Get.find<ServiceController>();
  String? uploadedImageUrl;

  @override
  void initState() {
    final s = widget.service;
    name = TextEditingController(text: s?.name ?? '');
    category = TextEditingController(text: s?.category ?? '');
    price = TextEditingController(text: s?.price.toString() ?? '');
    duration = TextEditingController(text: s?.duration.toString() ?? '');
    rating = TextEditingController(text: s?.rating.toString() ?? '');
    available = s?.availability ?? true;
    uploadedImageUrl = s?.imageUrl;
    super.initState();
  }

  void _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final url = await ImgurUploader.uploadImage(imageFile);

      if (url != null) {
        setState(() {
          uploadedImageUrl = url;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Image upload failed")),
        );
      }
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final service = Service(
        id: widget.service?.id ?? '',
        name: name.text,
        category: category.text,
        price: double.parse(price.text),
        imageUrl: uploadedImageUrl ?? '',
        availability: available,
        duration: duration.text,
        rating: double.parse(rating.text),
      );

      widget.service == null
          ? controller.addService(service)
          : controller.updateService(service.id, service);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.service == null ? "Add Service" : "Edit Service")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            // Name Field
            _buildTextField(controller: name, label: "Name"),
            // Category Field
            _buildTextField(controller: category, label: "Category"),
            // Price Field
            _buildTextField(controller: price, label: "Price", keyboardType: TextInputType.number),
            // Duration Field
            _buildTextField(controller: duration, label: "Duration (min)", keyboardType: TextInputType.number),
            // Rating Field
            _buildTextField(controller: rating, label: "Rating", keyboardType: TextInputType.number),

            SizedBox(height: 16),
            // Image Upload Section
            Text("Image", style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 8),
            uploadedImageUrl != null
                ? Image.network(uploadedImageUrl!, height: 150)
                : Text("No image selected"),
            TextButton.icon(
              onPressed: _pickAndUploadImage,
              icon: Icon(Icons.image),
              label: Text("Pick Image"),
            ),

            // Availability Toggle
            SwitchListTile(
              value: available,
              onChanged: (v) => setState(() => available = v),
              title: Text("Available"),
            ),

            SizedBox(height: 16),
            // Submit Button
            ElevatedButton(
              onPressed: _submit,
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a TextFormField with the theme
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: keyboardType,
        validator: _required,
      ),
    );
  }

  // Validator to ensure a field is not empty
  String? _required(String? val) => val == null || val.isEmpty ? 'Required' : null;
}
