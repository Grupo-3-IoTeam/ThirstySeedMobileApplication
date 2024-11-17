// lib/irrigation/infrastructure/data_sources/plot_data_source.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/plot_entity.dart';

class PlotDataSource {
  Future<List<Plot>> fetchPlots() async {
    final jsonString = await rootBundle.loadString('server/db.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;

    return (jsonData['plots'] as List).map((plotJson) {
      return Plot.fromJson(plotJson);
    }).toList();
  }
}