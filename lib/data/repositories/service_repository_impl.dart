import '../../domain/entities/service_entity.dart';
import '../../domain/repositories/service_repository.dart';
import '../model/service_model.dart';
import '../providers/service_api_provider.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceApiProvider apiProvider;

  ServiceRepositoryImpl(this.apiProvider);

  @override
  Future<List<ServiceEntity>> getServices() async {
    final services = await apiProvider.getServices();
     return services.map((service) => service.toEntity()).toList();}

  @override
  Future<ServiceEntity> getService(String id) async{
    final service= await apiProvider.getService(id);
    return service.toEntity();}

  @override
  Future<void> addService(ServiceEntity service) async {
    await apiProvider.addService(service as Service);
  }

  @override
  Future<void> updateService(String id, ServiceEntity service) async {
    await apiProvider.updateService(id, service as Service);
  }

  @override
  Future<void> deleteService(String id) async {
    await apiProvider.deleteService(id);
  }
}
