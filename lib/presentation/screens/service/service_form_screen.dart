import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/service_model.dart';
import '../../controllers/service_controller.dart';

class ServiceFormPage extends StatefulWidget {
  final Service? service;

  ServiceFormPage({this.service});

  @override
  _ServiceFormPageState createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController name, category, price, imageUrl, duration, rating;
  bool available = true;

  final controller = Get.find<ServiceController>();

  @override
  void initState() {
    final s = widget.service;
    name = TextEditingController(text: s?.name ?? '');
    category = TextEditingController(text: s?.category ?? '');
    price = TextEditingController(text: s?.price.toString() ?? '');
    imageUrl = TextEditingController(text: s?.imageUrl ?? '');
    duration = TextEditingController(text: s?.duration.toString() ?? '');
    rating = TextEditingController(text: s?.rating.toString() ?? '');
    available = s?.availability ?? true;
    super.initState();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final service = Service(
        id: widget.service?.id ?? '',
        name: name.text,
        category: category.text,
        price: double.parse(price.text),
        imageUrl: imageUrl.text,
        availability: available,
        duration: duration.text, 
        rating: double.parse(rating.text));
    

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
            TextFormField(controller: name, decoration: InputDecoration(labelText: "Name"), validator: _required),
            TextFormField(controller: category, decoration: InputDecoration(labelText: "Category"), validator: _required),
            TextFormField(controller: price, decoration: InputDecoration(labelText: "Price"), keyboardType: TextInputType.number, validator: _required),
            TextFormField(controller: imageUrl, decoration: InputDecoration(labelText: "Image URL")),
            TextFormField(controller: duration, decoration: InputDecoration(labelText: "Duration (min)"), keyboardType: TextInputType.number),
            TextFormField(controller: rating, decoration: InputDecoration(labelText: "Rating"), keyboardType: TextInputType.number),
            SwitchListTile(value: available, onChanged: (v) => setState(() => available = v), title: Text("Available")),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _submit, child: Text("Submit")),
          ],
        ),
      ),
    );
  }

  String? _required(String? val) => val == null || val.isEmpty ? 'Required' : null;
}
