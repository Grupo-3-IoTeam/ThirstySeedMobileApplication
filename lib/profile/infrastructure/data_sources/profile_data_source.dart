import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/profile_entity.dart';

class ProfileDataSource {
  final String baseUrl = 'https://thirstyseedapi-production.up.railway.app/api/v1';

  Future<bool> createProfile(ProfileEntity profile) async {
    final response = await http.post(
      Uri.parse('$baseUrl/profiles'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(profile.toJson()),
    );

    return response.statusCode == 201;
  }
}
