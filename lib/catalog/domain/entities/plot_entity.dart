// lib/catalog/domain/entities/plot_entity.dart

class Plot {
  final int id;
  final String name;
  final String image;

  Plot({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Plot.fromJson(Map<String, dynamic> json) {
    return Plot(
      id: json['id'],
      name: json['name'],
      image: json['image'], // Asegúrate de usar el mismo nombre que en el JSON
    );
  }
}
