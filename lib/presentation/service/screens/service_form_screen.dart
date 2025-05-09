import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/model/service_model.dart';
import '../../../data/services/image_uploader.dart';
import '../../controllers/service_controller.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/img_picker_section.dart';  

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
          SnackBar(content: Text('image_upload_failed'.tr)),
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
      appBar: AppBar(title: Text(widget.service == null ? 'add_service'.tr : 'edit_service'.tr)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            CustomTextField(controller: name, label: 'name'.tr, validator: _required),
            CustomTextField(controller: category, label: 'category'.tr, validator: _required),
            CustomTextField(controller: price, label: 'price'.tr, keyboardType: TextInputType.number, validator: _required),
            CustomTextField(controller: duration, label: 'duration'.tr, keyboardType: TextInputType.number, validator: _required),
            CustomTextField(controller: rating, label: 'rating'.tr, keyboardType: TextInputType.number, validator: _required),

            SizedBox(height: 16),

            // Replace the image picker section with the new widget
            ImagePickerSection(
              uploadedImageUrl: uploadedImageUrl,
              onPickImage: _pickAndUploadImage,
            ),

            SwitchListTile(
              value: available,
              onChanged: (v) => setState(() => available = v),
              title: Text('available'.tr),
            ),

            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              child: Text('submit'.tr),
            ),
          ],
        ),
      ),
    );
  }

  String? _required(String? val) => val == null || val.isEmpty ? 'required'.tr : null;
}
