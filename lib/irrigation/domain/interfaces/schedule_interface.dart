import 'package:thirstyseed/irrigation/domain/entities/schedule.dart';

abstract class ScheduleInterface {
  Future<List<Schedule>> fetchSchedules();
  Future<Schedule> getSchedule(String id);
  Future<void> createSchedule(Schedule schedule);
  Future<void> updateSchedule(Schedule schedule);
  Future<void> deleteSchedule(String id);
}