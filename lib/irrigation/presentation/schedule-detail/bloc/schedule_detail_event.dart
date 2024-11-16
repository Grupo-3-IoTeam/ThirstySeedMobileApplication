import 'package:equatable/equatable.dart';
import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';

abstract class ScheduleDetailEvent extends Equatable {
  const ScheduleDetailEvent();
}

class LoadScheduleDetailEvent extends ScheduleDetailEvent {
  final String scheduleId;

  const LoadScheduleDetailEvent(this.scheduleId);

  @override
  List<Object> get props => [scheduleId];
}

class UpdateScheduleEvent extends ScheduleDetailEvent {
  final ScheduleModel schedule;

  const UpdateScheduleEvent(this.schedule);

  @override
  List<Object> get props => [schedule];
}