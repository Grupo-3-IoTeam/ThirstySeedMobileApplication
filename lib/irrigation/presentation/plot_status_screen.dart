import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../irrigation/domain/entities/plot_entity.dart';

class PlotStatusScreen extends StatelessWidget {
  final int userId;  // Agregar el userId como parámetro

  // Constructor modificado para recibir userId
  PlotStatusScreen({Key? key, required this.userId}) : super(key: key);

  Future<List<Plot>> fetchPlots() async {
    final url = Uri.parse('https://thirstyseedapi-production.up.railway.app/api/v1/plot/$userId');  // Usar userId para solicitar las parcelas del usuario específico
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((plotData) => Plot.fromJson(plotData)).toList();
    } else {
      throw Exception('Error al obtener parcelas: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        title: const Text(
          'Estado de parcela',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Plot>>(
        future: fetchPlots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay parcelas disponibles'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final plot = snapshot.data![index];
              return ListTile(
                title: Text(plot.name),
                subtitle: Text('Ubicación: ${plot.location}, Extensión: ${plot.extension} m²'),
                onTap: () {
                  // Acciones adicionales al seleccionar una parcela, como abrir detalles o editar
                },
              );
            },
          );
        },
      ),
    );
  }
}

