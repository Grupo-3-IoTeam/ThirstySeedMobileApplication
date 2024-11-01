import 'package:thirstyseed/irrigation/infrastructure/data-sources/schedule_local_data_provider.dart';
import 'package:thirstyseed/irrigation/infrastructure/data-sources/schedule_remote_data_provider.dart';
import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';
import 'package:thirstyseed/irrigation/domain/entities/schedule.dart';
import 'package:thirstyseed/common/platform/connectivity.dart';

class ScheduleRepository {
  final Connectivity connectivity;
  final ScheduleLocalDataProvider localDataProvider;
  final ScheduleRemoteDataProvider remoteDataProvider;

  ScheduleRepository({
    required this.connectivity,
    required this.localDataProvider,
    required this.remoteDataProvider,
  });

  // Método para obtener todos los schedules
  Future<List<Schedule>> fetchSchedules() async {
    if (await connectivity.isConnected()) {
      try {
        // Si hay conexión, obtener datos remotos y almacenarlos en cache local
        final List<ScheduleModel> remoteSchedules = await remoteDataProvider.fetchSchedules();
        await localDataProvider.cacheSchedules(remoteSchedules);
        return remoteSchedules;
      } catch (e) {
        print("Error fetching schedules remotely: $e");
        // En caso de error, intenta obtener los datos de la cache local
        return await localDataProvider.fetchSchedules();
      }
    } else {
      // Sin conexión, obtiene los datos de la cache local
      return await localDataProvider.fetchSchedules();
    }
  }

  // Método para obtener un schedule por ID
  Future<Schedule?> getSchedule(String id) async {
    if (await connectivity.isConnected()) {
      try {
        // Si hay conexión, obtiene el schedule remoto y lo guarda en cache
        final ScheduleModel remoteSchedule = await remoteDataProvider.getSchedule(id);
        await localDataProvider.cacheSchedule(remoteSchedule);
        return remoteSchedule;
      } catch (e) {
        print("Error fetching schedule remotely: $e");
        // En caso de error, intenta obtener el schedule de la cache local
        return await localDataProvider.getSchedule(id);
      }
    } else {
      // Sin conexión, obtiene el schedule de la cache local
      return await localDataProvider.getSchedule(id);
    }
  }

  // Método para crear un nuevo schedule
  Future<Schedule> createSchedule(ScheduleModel schedule) async {
    if (await connectivity.isConnected()) {
      try {
        // Crear el schedule remotamente y guardarlo en la cache local
        final ScheduleModel createdSchedule = await remoteDataProvider.createSchedule(schedule);
        await localDataProvider.cacheSchedule(createdSchedule);
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
        // Elimina el schedule remotamente y también de la cache local
        await remoteDataProvider.deleteSchedule(id);
        await localDataProvider.deleteSchedule(id);
      } catch (e) {
        throw Exception("Error deleting schedule: $e");
      }
    } else {
      throw Exception("No internet connection. Cannot delete schedule.");
    }
  }
}
