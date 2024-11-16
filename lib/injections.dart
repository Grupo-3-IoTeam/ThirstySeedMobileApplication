import 'package:get_it/get_it.dart';
import 'package:thirstyseed/common/platform/conectivity.dart';
import 'package:thirstyseed/irrigation/application/schedule_facade_service.dart';
//import 'package:thirstyseed/irrigation/infrastructure/data-sources/schedule_local_data_provider.dart';
import 'package:thirstyseed/irrigation/infrastructure/data_sources/schedule_remote_data_provider.dart';
import 'package:thirstyseed/irrigation/infrastructure/repositories/schedule_repository.dart';


final GetIt serviceLocator = GetIt.instance;

Future<void> init() async {
  await irrigationDependencies();
}

Future<void> irrigationDependencies() async {
  // Application Layer
  serviceLocator.registerLazySingleton<ScheduleFacadeService>(
    () => ScheduleFacadeService(
      repository: serviceLocator<ScheduleRepository>(),
    ),
  );

  // Infrastructure Layer
  serviceLocator.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepository(
      connectivity: serviceLocator<Connectivity>(),
//      localDataProvider: serviceLocator<ScheduleLocalDataProvider>(),
      remoteDataProvider: serviceLocator<ScheduleRemoteDataProvider>(),
    ),
  );

 // serviceLocator.registerLazySingleton<ScheduleLocalDataProvider>(() => ScheduleLocalDataProvider());
  serviceLocator.registerLazySingleton<ScheduleRemoteDataProvider>(() => ScheduleRemoteDataProvider());

  // Common - Connectivity
  serviceLocator.registerLazySingleton<Connectivity>(() => Connectivity());
}