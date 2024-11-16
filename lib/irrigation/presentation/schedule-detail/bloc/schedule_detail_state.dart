import 'package:equatable/equatable.dart';
import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';

abstract class ScheduleDetailState extends Equatable {
  const ScheduleDetailState();

  @override
  List<Object> get props => [];
}

class ScheduleInitial extends ScheduleDetailState {}

class ScheduleLoading extends ScheduleDetailState {}

class ScheduleLoaded extends ScheduleDetailState {
  final ScheduleModel schedule;

  const ScheduleLoaded({required this.schedule});

  @override
  List<Object> get props => [schedule];
}

class ScheduleUpdating extends ScheduleDetailState {}

class ScheduleUpdated extends ScheduleDetailState {}

class ScheduleError extends ScheduleDetailState {
  final String message;

  const ScheduleError(this.message);

  @override
  List<Object> get props => [message];
}