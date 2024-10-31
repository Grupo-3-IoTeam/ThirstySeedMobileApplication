import 'dart:convert';
import 'package:flutter/services.dart';

class UserDataSource {
  Future<Map<String, dynamic>> fetchUserData() async {
    // Cargar el archivo JSON desde assets
    final String jsonString = await rootBundle.loadString('server/db.json');

    // Decodificar el JSON en un Map
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    // Retornar solo los datos del usuario
    return jsonData['user'];
  }
}