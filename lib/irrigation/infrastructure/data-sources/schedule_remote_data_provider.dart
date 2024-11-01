import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';

class ScheduleRemoteDataProvider {
  final String baseUrl = "http://localhost:8080/api/v1/schedules";

  // Método para obtener todos los schedules
  Future<List<ScheduleModel>> fetchSchedules() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ScheduleModel.fromJson(json)).toList();
    } else {
      throw Exception("Error fetching schedules");
    }
  }

  // Método para obtener un schedule por ID
  Future<ScheduleModel> getSchedule(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    if (response.statusCode == 200) {
      return ScheduleModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error fetching schedule with id $id");
    }
  }

  // Método para crear un nuevo schedule
  Future<ScheduleModel> createSchedule(ScheduleModel schedule) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(schedule.toJson()),
    );

    if (response.statusCode == 201) {
      return ScheduleModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error creating schedule");
    }
  }

  // Método para eliminar un schedule por ID
  Future<void> deleteSchedule(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    if (response.statusCode != 204) {
      throw Exception("Error deleting schedule with id $id");
    }
  }
}
