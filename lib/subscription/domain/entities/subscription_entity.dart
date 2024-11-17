class Subscription {
  final int? id; // ID opcional
  final int userId;
  final String planType;
  final int nodeCount;
  final String validationCode;

  Subscription({
    this.id, // ID opcional para cuando se devuelva desde la API
    required this.userId,
    required this.planType,
    required this.nodeCount,
    required this.validationCode,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'], // Puede ser null si no está en la respuesta
      userId: json['userId'] ?? 0,
      planType: json['planType'] ?? '',
      nodeCount: json['nodeCount'] ?? 0,
      validationCode: json['validationCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id, // Solo incluye el ID si no es null
      'userId': userId,
      'planType': planType,
      'nodeCount': nodeCount,
      'validationCode': validationCode,
    };
  }
}

