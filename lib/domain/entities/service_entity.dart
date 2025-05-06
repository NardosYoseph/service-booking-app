// domain/entities/service_entity.dart
class ServiceEntity {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  final bool availability;
  final String duration;
  final double rating;

  ServiceEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.availability,
    required this.duration,
    required this.rating,
  });
}
