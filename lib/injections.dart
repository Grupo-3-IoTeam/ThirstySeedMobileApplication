import 'package:get_it/get_it.dart';
import 'package:thirstyseed/irrigation/application/schedule_facade_service.dart';
import 'package:thirstyseed/irrigation/infrastructure/data-sources/schedule_local_data_provider.dart';
import 'package:thirstyseed/irrigation/infrastructure/data-sources/schedule_remote_data_provider.dart';
import 'package:thirstyseed/irrigation/infrastructure/repositories/schedule_repository.dart';
import 'package:thirstyseed/common/platform/connectivity.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  // Dependencias de la capa de irrigación
  irrigationDependencies();
}

Future<void> irrigationDependencies() async {
  // Presentation Layer

  // Application Layer
  serviceLocator.registerLazySingleton(
    () => ScheduleFacadeService(
      repository: serviceLocator(),
    ),
  );

  // Infrastructure Layer
  serviceLocator.registerLazySingleton(
    () => ScheduleRepository(
      connectivity: serviceLocator(),
      localDataProvider: serviceLocator(),
      remoteDataProvider: serviceLocator(),
    ),
  );

  // Infrastructure Layer
  serviceLocator.registerLazySingleton(
    () => ScheduleLocalDataProvider(),
  );

  serviceLocator.registerLazySingleton(
    () => ScheduleRemoteDataProvider(),
  );

  // Common - Connectivity
  serviceLocator.registerLazySingleton(
    () => Connectivity(),
  );
}
