class Plot {
  final int id;
  final int userId;
  final String name;
  final String location;
  final int extension;
  final int size;
  final String imageUrl;

  Plot({
    required this.id,
    required this.userId,
    required this.name,
    required this.location,
    required this.extension,
    required this.size,
    required this.imageUrl,
  });

  factory Plot.fromJson(Map<String, dynamic> json) {
    return Plot(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      extension: json['extension'] ?? 0,
      size: json['size'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'location': location,
      'extension': extension,
      'size': size,
      'imageUrl': imageUrl,
    };
  }
}
