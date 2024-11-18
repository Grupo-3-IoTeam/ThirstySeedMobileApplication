import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/node_entity.dart';
import 'package:http/http.dart' as http;

class PlotDataSource {
  final String baseUrl;
  PlotDataSource(this.baseUrl);

  Future<List<Node>> fetchNodes() async {
    final jsonString = await rootBundle.loadString('server/db.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;

    return (jsonData['plots'] as List).map((plotJson) {
      return Node.fromJson(plotJson);
    }).toList();
  }
  Future<Node> createNode(Node plot) async {
    final response = await http.post(
      Uri.parse('$baseUrl/node'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(plot.toJson()),
    );
    if (response.statusCode == 200) {
      return Node.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create plot');
    }
  }
}