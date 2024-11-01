import 'package:thirstyseed/irrigation/domain/entities/schedule.dart';

class ScheduleModel extends Schedule {
  const ScheduleModel({
    required super.id,
    required super.plotId,
    required super.waterAmount,
    required super.pressure,
    required super.sprinklerRadius,
    required super.expectedMoisture,
    required super.estimatedTimeHours,
    required super.setTime,
    required super.angle,
    required super.isAutomatic,
  });

  // Factory constructor to create a ScheduleModel from JSON
  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'],
      plotId: json['plotId'],
      waterAmount: json['waterAmount'],
      pressure: json['pressure'],
      sprinklerRadius: json['sprinklerRadius'],
      expectedMoisture: json['expectedMoisture'],
      estimatedTimeHours: json['estimatedTimeHours'],
      setTime: json['setTime'],
      angle: json['angle'],
      isAutomatic: json['isAutomatic'],
    );
  }

  // Method to convert ScheduleModel to JSON
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
