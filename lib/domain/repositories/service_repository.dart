import '../entities/service_entity.dart';

abstract class ServiceRepository {
  Future<List<ServiceEntity>> getServices();
  Future<ServiceEntity> getService(String id);
  Future<void> addService(ServiceEntity service);
  Future<void> updateService(String id, ServiceEntity service);
  Future<void> deleteService(String id);
}
