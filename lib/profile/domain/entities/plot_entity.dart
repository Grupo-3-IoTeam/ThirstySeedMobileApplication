class Plot {
  final String id;
  final String name;
  final String location;
  final String extension;
  final String status;
  final String size;
  final String imageUrl;

  Plot({
    required this.id,
    required this.name,
    required this.location,
    required this.extension,
    required this.status,
    required this.size,
    required this.imageUrl,
  });

  factory Plot.fromJson(Map<String, dynamic> json) {
    return Plot(
      id: json['id'] ?? '', // Proporciona un valor predeterminado si es null
      name: json['name'] ?? 'Unnamed Plot',
      location: json['location'] ?? 'Unknown Location',
      extension: json['extension'] ?? '0',
      status: json['status'] ?? 'Unknown',
      size: json['size'] ?? '0',
      imageUrl: json['imageUrl'] ?? '', // URL vacío si no hay imagen
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'extension': extension,
        'status': status,
        'size': size,
        'imageUrl': imageUrl,
      };
}
