import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:thirstyseed/irrigation/application/schedule_facade_service.dart';
import './schedule_detail_event.dart';
import './schedule_detail_state.dart';

class ScheduleDetailBloc extends Bloc<ScheduleDetailEvent, ScheduleDetailState> {
  final ScheduleFacadeService scheduleService;

  ScheduleDetailBloc({required this.scheduleService}) : super(ScheduleInitial());

  Stream<ScheduleDetailState> mapEventToState(ScheduleDetailEvent event) async* {
    if (event is LoadScheduleDetailEvent) {
      yield* _mapLoadScheduleToState(event);
    }
  }

  Stream<ScheduleDetailState> _mapLoadScheduleToState(LoadScheduleDetailEvent event) async* {
    yield ScheduleLoading();
    try {
      final schedule = await scheduleService.getSchedule(event.scheduleId);
      if (schedule == null) {
        yield const ScheduleError("Schedule not found.");
      } else {
        yield ScheduleLoaded(schedule: schedule);
      }
    } catch (error) {
      yield const ScheduleError("Failed to load schedule details.");
    }
  }
}