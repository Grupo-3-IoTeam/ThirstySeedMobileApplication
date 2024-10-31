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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logo': logo,
    };
  }
}
