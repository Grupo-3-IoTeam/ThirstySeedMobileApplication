import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String id;
  final String plotId;
  final double waterAmount;
  final double pressure;
  final double sprinklerRadius;
  final double expectedMoisture;
  final int estimatedTimeHours;
  final String setTime;
  final int angle;
  final bool isAutomatic;

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
}
