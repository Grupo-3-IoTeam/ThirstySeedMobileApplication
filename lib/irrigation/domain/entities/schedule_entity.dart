import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final int id;
  final int plotId;
  final int waterAmount; // Cantidad de agua en litros
  final int pressure; // Presión del agua en bares
  final int sprinklerRadius; // Radio del aspersor en metros
  final int expectedMoisture; // Humedad esperada en porcentaje
  final int estimatedTimeHours; // Tiempo estimado en horas
  final String setTime; // Hora programada para el riego
  final int angle; // Ángulo de riego en grados
  final bool isAutomatic; // Indica si el riego es automático

  const Schedule({
    required this.id,
    required this.plotId,
    required this.waterAmount,
    required this.pressure,
    required this.sprinklerRadius,
    required this.expectedMoisture,
    required this.estimatedTimeHours,
    required this.setTime,
    required this.angle,
    required this.isAutomatic,
  });

  @override
  List<Object> get props => [
        id,
        plotId,
        waterAmount,
        pressure,
        sprinklerRadius,
        expectedMoisture,
        estimatedTimeHours,
        setTime,
        angle,
        isAutomatic,
      ];

  /// Crear un objeto `Schedule` desde un JSON
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] ?? 0,
      plotId: json['plotId'] ?? 0,
      waterAmount: json['waterAmount'] ?? 0,
      pressure: json['pressure'] ?? 0,
      sprinklerRadius: json['sprinklerRadius'] ?? 0,
      expectedMoisture: json['expectedMoisture'] ?? 0,
      estimatedTimeHours: json['estimatedTimeHours'] ?? 0,
      setTime: json['setTime'] ?? '',
      angle: json['angle'] ?? 0,
      isAutomatic: json['isAutomatic'] ?? false,
    );
  }

  /// Convertir un objeto `Schedule` a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plotId': plotId,
      'waterAmount': waterAmount,
      'pressure': pressure,
      'sprinklerRadius': sprinklerRadius,
      'expectedMoisture': expectedMoisture,
      'estimatedTimeHours': estimatedTimeHours,
      'setTime': setTime,
      'angle': angle,
      'isAutomatic': isAutomatic,
    };
  }
}