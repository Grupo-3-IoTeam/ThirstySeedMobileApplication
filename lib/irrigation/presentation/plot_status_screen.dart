import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../irrigation/domain/entities/plot_entity.dart';

typedef FetchPlots = Future<List<Plot>> Function();

Future<List<Plot>> fetchPlotsFromBackend() async {
  final url = Uri.parse('https://thirstyseedapi-production.up.railway.app/api/v1/plot');  // Cambié la URL aquí
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((plotData) => Plot.fromJson(plotData)).toList();
  } else {
    throw Exception('Error al obtener parcelas: ${response.statusCode}');
  }
}

class PlotStatusScreen extends StatelessWidget {
  final FetchPlots fetchPlots;

  PlotStatusScreen({Key? key, required this.fetchPlots}) : super(key: key);

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
          // Caso cuando está cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Caso cuando hay un error
          else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Caso cuando no hay datos
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay parcelas disponibles'));
          }

          // Caso cuando se obtienen datos exitosamente
          else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final plot = snapshot.data!.first;
            // Aquí puedes continuar con el resto de la lógica.
            return Center(child: Text('Parcela: ${plot.name}')); // Ejemplo de uso del primer plot.
          }

          // Retorno predeterminado en caso de que no caiga en los otros casos
          return const Center(child: Text('Algo salió mal'));
        },
      ),
    );
  }
}
