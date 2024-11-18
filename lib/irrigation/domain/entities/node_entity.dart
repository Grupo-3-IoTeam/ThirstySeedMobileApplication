class Node {
  final int id;
  final int plotId;
  final String location;
  final int moisture;
  final String indicator;
  final bool isActive;  // Cambié 'status' a 'isActive'
  final String productcode;

  Node({
    required this.id,
    required this.plotId,
    required this.location,
    required this.moisture,
    required this.indicator,
    required this.isActive,  // Cambié 'status' a 'isActive'
    required this.productcode,
  });

  factory Node.fromJson(Map<String, dynamic> json) {
    return Node(
      id: json['id'] ?? 0,
      plotId: json['plotId'] ?? 0,
      location: json['nodelocation'] ?? '',  // Cambié 'location' a 'nodelocation'
      moisture: json['moisture'] ?? 0,
      indicator: json['indicator'] ?? '',
      isActive: json['isActive'] ?? false,  // Cambié 'status' a 'isActive'
      productcode: json['productcode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plotId': plotId,
      'nodelocation': location,  // Cambié 'location' a 'nodelocation'
      'moisture': moisture,
      'indicator': indicator,
      'isActive': isActive,  // Cambié 'status' a 'isActive'
      'productcode': productcode,
    };
  }
}
