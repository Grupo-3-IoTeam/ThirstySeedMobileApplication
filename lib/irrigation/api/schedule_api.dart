import 'package:thirstyseed/irrigation/application/schedule_facade_service.dart';
import 'package:thirstyseed/irrigation/domain/entities/schedule.dart';
import 'package:thirstyseed/injections.dart';
import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';

class ScheduleApi {
  final ScheduleFacadeService scheduleFacade = serviceLocator<ScheduleFacadeService>();

  // Obtener todos los schedules
  Future<List<Schedule>> fetchSchedules() async {
    try {
      return await scheduleFacade.fetchSchedules();
    } catch (e) {
      print("Error fetching schedules: $e");
      return [];
    }
  }

  // Obtener un schedule específico por ID
  Future<Schedule?> getSchedule(String id) async {
    try {
      return await scheduleFacade.getSchedule(id);
    } catch (e) {
      print("Error fetching schedule by id: $e");
      return null;
    }
  }

  // Crear un nuevo schedule
  Future<Schedule?> createSchedule(ScheduleModel schedule) async {
    try {
      return await scheduleFacade.createSchedule(schedule);
    } catch (e) {
      print("Error creating schedule: $e");
      return null;
    }
  }

  // Eliminar un schedule por ID
  Future<void> deleteSchedule(String id) async {
    try {
      await scheduleFacade.deleteSchedule(id);
      print("Schedule with id $id deleted successfully.");
    } catch (e) {
      print("Error deleting schedule: $e");
    }
  }
}