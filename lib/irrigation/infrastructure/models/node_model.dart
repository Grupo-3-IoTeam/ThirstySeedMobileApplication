class NodeModel {
  final String id; // ID autogenerado
  final String plotId; // ID de la parcela a la que pertenece
  final String name;
  final String type;
  final String location;

  NodeModel({
    required this.id,
    required this.plotId,
    required this.name,
    required this.type,
    required this.location,
  });

  // Convertir NodeModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plotId': plotId,
      'name': name,
      'type': type,
      'location': location,
    };
  }

  // Crear NodeModel desde JSON
  factory NodeModel.fromJson(Map<String, dynamic> json) {
    return NodeModel(
      id: json['id'],
      plotId: json['plotId'],
      name: json['name'],
      type: json['type'],
      location: json['location'],
    );
  }
}
