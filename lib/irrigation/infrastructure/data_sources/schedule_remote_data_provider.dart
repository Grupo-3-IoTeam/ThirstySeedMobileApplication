import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';

class ScheduleRemoteDataProvider {
  final String baseUrl = "https://thirstyseedapi-production.up.railway.app/api/v1/schedules";

  // Método para obtener todos los schedules (GET)
  Future<List<ScheduleModel>> fetchSchedules() async {
    print("Fetching all schedules from $baseUrl");
    final response = await http.get(Uri.parse(baseUrl));

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print("Data fetched successfully. Total schedules: ${data.length}");
      return data.map((json) => ScheduleModel.fromJson(json)).toList();
    } else {
      print("Error fetching schedules. Status code: ${response.statusCode}");
      throw Exception("Error fetching schedules");
    }
  }

  // Método para obtener un schedule por ID (GET)
  Future<ScheduleModel> getSchedule(String id) async {
    print("Fetching schedule with id $id from $baseUrl/$id");
    final response = await http.get(Uri.parse("$baseUrl/$id"));

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      return ScheduleModel.fromJson(json.decode(response.body));
    } else {
      print("Error fetching schedule with id $id. Status code: ${response.statusCode}");
      throw Exception("Error fetching schedule with id $id");
    }
  }

  // Método para crear un nuevo schedule (POST)
  Future<ScheduleModel> createSchedule(ScheduleModel schedule) async {
    print("Creating a new schedule with data: ${schedule.toJson()}");
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(schedule.toJson()),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 201 || response.statusCode == 200) {
      return ScheduleModel.fromJson(json.decode(response.body));
    } else {
      print("Error creating schedule. Status code: ${response.statusCode}");
      throw Exception("Error creating schedule");
    }
  }

  // Método para eliminar un schedule por ID (DELETE)
  Future<void> deleteSchedule(String id) async {
    print("Deleting schedule with id $id from $baseUrl/$id");
    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    print("Response status: ${response.statusCode}");

    if (response.statusCode == 204 || response.statusCode == 200) {
      print("Schedule with id $id deleted successfully.");
    } else {
      print("Error deleting schedule with id $id. Status code: ${response.statusCode}");
      throw Exception("Error deleting schedule with id $id");
    }
  }
}