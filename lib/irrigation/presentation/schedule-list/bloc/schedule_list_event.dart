import 'package:equatable/equatable.dart';

abstract class ScheduleListEvent extends Equatable {
  const ScheduleListEvent();
}

class LoadScheduleListEvent extends ScheduleListEvent {
  @override
  List<Object?> get props => [];
}