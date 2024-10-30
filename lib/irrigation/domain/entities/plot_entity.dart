import 'package:thirstyseed/irrigation/domain/entities/node_entity.dart';

class Plot {
  final int id;
  final String name;
  final String location;
  final int extension;
  final String status;
  final int size;
  final String lastIrrigationDate;
  final String imageUrl;
  final List<Node> nodes;
  final int installedNodes; // Asegúrate de que este campo esté aquí

  Plot({
    required this.id,
    required this.name,
    required this.location,
    required this.extension,
    required this.status,
    required this.size,
    required this.lastIrrigationDate,
    required this.imageUrl,
    required this.nodes,
    required this.installedNodes, // Y aquí también
  });

  factory Plot.fromJson(Map<String, dynamic> json) {
    return Plot(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      extension: json['extension'],
      status: json['status'],
      size: json['size'],
      lastIrrigationDate: json['lastIrrigationDate'],
      imageUrl: json['imageUrl'],
      nodes: (json['nodes'] as List).map((nodeJson) => Node.fromJson(nodeJson)).toList(),
      installedNodes: json['installedNodes'] ?? 0, // Agrega esto para leer del JSON
    );
  }
}
