// lib/catalog/domain/entities/water_supplier_entity.dart

class WaterSupplier {
  final String name;
  final String logo;

  WaterSupplier({
    required this.name,
    required this.logo,
  });

  factory WaterSupplier.fromJson(Map<String, dynamic> json) {
    return WaterSupplier(
      name: json['name'],
      logo: json['logo'],
    );
  }
}
