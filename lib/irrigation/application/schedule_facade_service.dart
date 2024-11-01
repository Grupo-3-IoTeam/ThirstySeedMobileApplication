import 'package:thirstyseed/irrigation/domain/entities/schedule.dart';
import 'package:thirstyseed/irrigation/domain/logic/irrigation_logic.dart';
import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';
import 'package:thirstyseed/irrigation/infrastructure/repositories/schedule_repository.dart';

class ScheduleFacadeService with IrrigationLogic {
  const ScheduleFacadeService({
    required this.repository,
  });

  final ScheduleRepository repository;

  // Método para obtener todos los schedules
  Future<List<Schedule>> fetchSchedules() async {
    return await repository.fetchSchedules();
  }

  // Método para obtener un schedule por ID
  Future<Schedule?> getSchedule(String id) async {
    return await repository.getSchedule(id);
  }

  // Método para crear un nuevo schedule
  Future<Schedule> createSchedule(ScheduleModel schedule) async {
    return await repository.createSchedule(schedule);
  }

  // Método para eliminar un schedule
  Future<void> deleteSchedule(String id) async {
    return await repository.deleteSchedule(id);
  }
}
