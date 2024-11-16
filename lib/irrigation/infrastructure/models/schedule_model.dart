import 'package:thirstyseed/irrigation/domain/entities/schedule.dart';

class ScheduleModel extends Schedule {
  const ScheduleModel({
    int? id, // Hacer `id` opcional
    required int plotId,
    required int waterAmount, // Ahora es int
    required int pressure, // Ahora es int
    required int sprinklerRadius, // Ahora es int
    required int expectedMoisture, // Ahora es int
    required int estimatedTimeHours,
    required String setTime,
    required int angle,
    required bool isAutomatic,
  }) : super(
          id: id ?? 0, // Si no se proporciona `id`, usa un valor predeterminado (por ejemplo, 0)
          plotId: plotId,
          waterAmount: waterAmount,
          pressure: pressure,
          sprinklerRadius: sprinklerRadius,
          expectedMoisture: expectedMoisture,
          estimatedTimeHours: estimatedTimeHours,
          setTime: setTime,
          angle: angle,
          isAutomatic: isAutomatic,
        );

  // Constructor `fromJson` que convierte valores de `double` a `int` si es necesario
  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] as int?,
      plotId: json['plotId'] as int,
      waterAmount: (json['waterAmount'] is double)
          ? (json['waterAmount'] as double).round()
          : json['waterAmount'] as int,
      pressure: (json['pressure'] is double)
          ? (json['pressure'] as double).round()
          : json['pressure'] as int,
      sprinklerRadius: (json['sprinklerRadius'] is double)
          ? (json['sprinklerRadius'] as double).round()
          : json['sprinklerRadius'] as int,
      expectedMoisture: (json['expectedMoisture'] is double)
          ? (json['expectedMoisture'] as double).round()
          : json['expectedMoisture'] as int,
      estimatedTimeHours: json['estimatedTimeHours'] as int,
      setTime: json['setTime'] as String,
      angle: json['angle'] as int,
      isAutomatic: json['isAutomatic'] == true || json['isAutomatic'] == 1,
    );
  }

  // Método `toJson` para convertir a JSON, omitiendo `id` si es necesario
  Map<String, dynamic> toJson() {
    return {
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