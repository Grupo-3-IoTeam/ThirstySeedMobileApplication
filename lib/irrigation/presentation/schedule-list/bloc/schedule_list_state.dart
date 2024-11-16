import 'package:equatable/equatable.dart';
import 'package:thirstyseed/irrigation/domain/entities/schedule.dart';

abstract class ScheduleListState extends Equatable {
  const ScheduleListState();
}

class ScheduleListInitial extends ScheduleListState {
  @override
  List<Object?> get props => [];
}

class ScheduleListLoading extends ScheduleListState {
  @override
  List<Object?> get props => [];
}

class ScheduleListLoaded extends ScheduleListState {
  final List<Schedule> schedules;

  const ScheduleListLoaded({required this.schedules});

  @override
  List<Object?> get props => [schedules];
}

class ScheduleListError extends ScheduleListState {
  final String message;

  const ScheduleListError(this.message);

  @override
  List<Object?> get props => [message];
}