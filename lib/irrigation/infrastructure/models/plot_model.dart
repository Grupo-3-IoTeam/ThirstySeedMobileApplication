class PlotModel {
  final String id;
  final String name;
  final String location;
  final double extension;
  final String imageUrl;

  PlotModel({
    required this.id,
    required this.name,
    required this.location,
    required this.extension,
    required this.imageUrl,
  });

  /// Conversión desde JSON
  factory PlotModel.fromJson(Map<String, dynamic> json) {
    return PlotModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      extension: (json['extension'] as num).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  /// Conversión a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'extension': extension,
      'imageUrl': imageUrl,
    };
  }
}
