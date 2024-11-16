import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/node_model.dart';

class NodeRepository {
  final String baseUrl = 'http://localhost:3000/nodes'; // Cambia por tu backend.

  Future<List<NodeModel>> getNodesByPlotId(String plotId) async {
    final response = await http.get(Uri.parse('$baseUrl?plotId=$plotId'));
    if (response.statusCode == 200) {
      final List nodes = json.decode(response.body);
      return nodes.map((node) => NodeModel.fromJson(node)).toList();
    } else {
      throw Exception('Error al obtener nodos');
    }
  }

  Future<void> createNode(NodeModel node) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(node.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al registrar el nodo');
    }
  }
}
