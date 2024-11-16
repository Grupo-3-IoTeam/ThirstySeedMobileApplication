import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:thirstyseed/irrigation/application/schedule_facade_service.dart';
import 'schedule_list_event.dart';
import 'schedule_list_state.dart';

class ScheduleListBloc extends Bloc<ScheduleListEvent, ScheduleListState> {
  final ScheduleFacadeService scheduleService;

  ScheduleListBloc({required this.scheduleService}) : super(ScheduleListInitial()) {
    on<LoadScheduleListEvent>(_onLoadScheduleList);
  }

  Future<void> _onLoadScheduleList(LoadScheduleListEvent event, Emitter<ScheduleListState> emit) async {
    emit(ScheduleListLoading());
    try {
      final schedules = await scheduleService.fetchSchedules();
      emit(ScheduleListLoaded(schedules: schedules));
    } catch (error) {
      print("Error al cargar los horarios: $error"); 
      emit(const ScheduleListError("Failed to load schedules."));
    }
  }
}