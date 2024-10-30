class IrrigationSettings {
  final int? id;
  final int plotId;
  final String expectedMoisture;
  final String estimatedTime;
  final String requiredWaterAmount;
  final String sprinklerRadius;
  final String setTime;
  final String angle;
  final String pressure;
  final bool isAutomatic;

  IrrigationSettings({
    this.id,
    required this.plotId,
    required this.expectedMoisture,
    required this.estimatedTime,
    required this.requiredWaterAmount,
    required this.sprinklerRadius,
    required this.setTime,
    required this.angle,
    required this.pressure,
    required this.isAutomatic,
  });

  // Método para crear una instancia de IrrigationSettings a partir de JSON
  factory IrrigationSettings.fromJson(Map<String, dynamic> json) {
    return IrrigationSettings(
      id: json['id'] as int?,
      plotId: json['plotId'] as int,
      expectedMoisture: json['expectedMoisture'] as String,
      estimatedTime: json['estimatedTime'] as String,
      requiredWaterAmount: json['requiredWaterAmount'] as String,
      sprinklerRadius: json['sprinklerRadius'] as String,
      setTime: json['setTime'] as String,
      angle: json['angle'] as String,
      pressure: json['pressure'] as String,
      isAutomatic: json['isAutomatic'] as bool,
    );
  }

  // Método para convertir una instancia de IrrigationSettings a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plotId': plotId,
      'expectedMoisture': expectedMoisture,
      'estimatedTime': estimatedTime,
      'requiredWaterAmount': requiredWaterAmount,
      'sprinklerRadius': sprinklerRadius,
      'setTime': setTime,
      'angle': angle,
      'pressure': pressure,
      'isAutomatic': isAutomatic,
    };
  }
}
