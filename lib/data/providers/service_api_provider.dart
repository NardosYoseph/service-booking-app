import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../core/util/constants.dart';
import '../model/service_model.dart';

class ServiceApiProvider {
  final Dio _dio = Dio();
  final String baseUrl = AppConstants.baseUrl;
final Box<Service> serviceBox = Hive.box<Service>('services');

Future<List<Service>> getServices() async {
  try {
    print('Fetching services from API...');
    final response = await _dio.get(baseUrl);
    print('Response: ${response.data}');
    final List<Service> services = (response.data as List)
        .map((item) => Service.fromJson(item))
        .toList();

    await serviceBox.clear();
    for (var service in services) {
      await serviceBox.put(service.id, service);
    }

    return services;
  } catch (e) {
    if (serviceBox.isNotEmpty) {
      return serviceBox.values.toList();
    } else {
      rethrow;
    }
  }
}
Future<Service> getService(String id) async {
  try {
    final response = await _dio.get('$baseUrl/$id');
    final Service service = Service.fromJson(response.data);

    await serviceBox.put(service.id, service);
    return service;
  } catch (e) {
    final cachedService = serviceBox.get(id);
    if (cachedService != null) {
      return cachedService;
    } else {
      rethrow;
    }
  }
}

  Future<void> addService(Service service) async {
    print('Adding service to API...');
    // service.remove('id');
    print(baseUrl);
    await _dio.post(baseUrl, data: service.toJson());
  }

  Future<void> updateService(String id, Service service) async {
    await _dio.put('$baseUrl/$id', data: service.toJson());
  }

  Future<void> deleteService(String id) async {
    await _dio.delete('$baseUrl/$id');
  }
}
