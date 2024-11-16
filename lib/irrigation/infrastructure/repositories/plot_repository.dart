import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/plot_model.dart';

class PlotRepository {
  final String _baseUrl = "http://localhost:3000/plots"; // Cambia esto según tu backend

  /// Obtiene todas las parcelas del backend
  Future<List<PlotModel>> getAllPlots() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((plot) => PlotModel.fromJson(plot)).toList();
    } else {
      throw Exception("Error al obtener las parcelas: ${response.statusCode}");
    }
  }

  /// Crea una nueva parcela en el backend
  Future<void> createPlot(PlotModel plot) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(plot.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Error al crear la parcela: ${response.statusCode}");
    }
  }
}
