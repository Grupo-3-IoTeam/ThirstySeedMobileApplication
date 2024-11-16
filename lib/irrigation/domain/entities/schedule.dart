import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final int id;
  final int plotId;
  final int waterAmount; // Cambiado a int
  final int pressure; // Cambiado a int
  final int sprinklerRadius; // Cambiado a int
  final int expectedMoisture; // Cambiado a int
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