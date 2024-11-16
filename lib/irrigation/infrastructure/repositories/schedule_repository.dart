import 'package:thirstyseed/common/platform/conectivity.dart';
import 'package:thirstyseed/irrigation/infrastructure/data_sources/schedule_remote_data_provider.dart';
import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';
import 'package:thirstyseed/irrigation/domain/entities/schedule.dart';

class ScheduleRepository {
  final Connectivity connectivity;
  final ScheduleRemoteDataProvider remoteDataProvider;

  ScheduleRepository({
    required this.connectivity,
    required this.remoteDataProvider,
  });

  // Método para obtener todos los schedules
  Future<List<Schedule>> fetchSchedules() async {
    if (await connectivity.isConnected()) {
      try {
        // Si hay conexión, obtener datos remotos
        final List<ScheduleModel> remoteSchedules = await remoteDataProvider.fetchSchedules();
        return remoteSchedules;
      } catch (e) {
        print("Error fetching schedules remotely: $e");
        throw Exception("Error fetching schedules: $e");
      }
    } else {
      throw Exception("No internet connection. Cannot fetch schedules.");
    }
  }

  // Método para obtener un schedule por ID
  Future<Schedule?> getSchedule(String id) async {
    if (await connectivity.isConnected()) {
      try {
        // Si hay conexión, obtiene el schedule remoto
        final ScheduleModel remoteSchedule = await remoteDataProvider.getSchedule(id);
        return remoteSchedule;
      } catch (e) {
        print("Error fetching schedule remotely: $e");
        throw Exception("Error fetching schedule: $e");
      }
    } else {
      throw Exception("No internet connection. Cannot fetch schedule.");
    }
  }

  // Método para crear un nuevo schedule
  Future<Schedule> createSchedule(ScheduleModel schedule) async {
    if (await connectivity.isConnected()) {
      try {
        // Crear el schedule remotamente
        final ScheduleModel createdSchedule = await remoteDataProvider.createSchedule(schedule);
        return createdSchedule;
      } catch (e) {
        throw Exception("Error creating schedule: $e");
      }
    } else {
      throw Exception("No internet connection. Cannot create schedule.");
    }
  }

  // Método para eliminar un schedule por ID
  Future<void> deleteSchedule(String id) async {
    if (await connectivity.isConnected()) {
      try {
        // Elimina el schedule remotamente
        await remoteDataProvider.deleteSchedule(id);
      } catch (e) {
        throw Exception("Error deleting schedule: $e");
      }
    } else {
      throw Exception("No internet connection. Cannot delete schedule.");
    }
  }
}