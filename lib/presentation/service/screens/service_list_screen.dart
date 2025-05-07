import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/util/routing/app_routes.dart';
import '../../controllers/service_controller.dart';
import '../widgets/service_search_bar.dart';
import '../widgets/service_list.dart';

class ServiceListPage extends StatelessWidget {
  final ServiceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Get.toNamed(AppRoutes.serviceForm),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: ServiceSearchBar(),
          ),
          Expanded(child: ServiceList()),
        ],
      ),
    );
  }
}
