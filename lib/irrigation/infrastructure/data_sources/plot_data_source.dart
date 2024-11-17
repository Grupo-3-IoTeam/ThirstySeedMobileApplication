// lib/irrigation/infrastructure/data_sources/plot_data_source.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/plot_entity.dart';
import 'package:http/http.dart' as http;

class PlotDataSource {
    final String baseUrl;
    PlotDataSource(this.baseUrl);

  Future<List<Plot>> fetchPlots() async {
    final jsonString = await rootBundle.loadString('server/db.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;

    return (jsonData['plots'] as List).map((plotJson) {
      return Plot.fromJson(plotJson);
    }).toList();
  }
  Future<Plot> createPlot(Plot plot) async {
    final response = await http.post(
      Uri.parse('$baseUrl/plot'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(plot.toJson()),
    );
    if (response.statusCode == 200) {
      return Plot.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create plot');
    }
  }
}