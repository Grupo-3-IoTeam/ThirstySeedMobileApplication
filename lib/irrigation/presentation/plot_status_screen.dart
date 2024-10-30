// lib/catalog/presentation/screens/plot_status_screen.dart
import 'package:flutter/material.dart';
import '../../irrigation/application/fetch_plots.dart';
import '../../irrigation/domain/entities/plot_entity.dart';

class PlotStatusScreen extends StatelessWidget {
  final FetchPlots fetchPlots;

  const PlotStatusScreen({Key? key, required this.fetchPlots}) : super(key: key);

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

          final plot = snapshot.data!.first;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen de la parcela
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(plot.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Terreno',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    _buildInfoBox(plot.name, width: 170),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Extensión',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    _buildInfoBox('${plot.extension} m2', width: 170),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Nodos',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    _buildInfoBox('${plot.installedNodes}', width: 170),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Último riego',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    _buildInfoBox(plot.lastIrrigationDate, width: 170),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción para programar riego
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text('Programar riego',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                    
                  ),
                ),
                const Divider(height: 30),
                const Text(
                  'Estado de nodos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10),
                // Lista de nodos
                Column(
                  children: plot.nodes.map((node) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.water_damage_outlined, color: Colors.blue, size: 40),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ubicación: ${node.location}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Text('Humedad: ${node.moisture}%'),
                                  Text('Indicador: ${node.indicator}'),
                                  Text(
                                    'Estado: ${node.status}',
                                    style: TextStyle(
                                      color: node.status == "Error" ? Colors.red : Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (plot.nodes.any((node) => node.status == "Error"))
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Uno o más nodos de tu parcela tienen un error. Contacta con soporte:',
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Acción para contactar soporte
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          child: const Text('Contactar con soporte',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoBox(String info, {double width = 100}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        info,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }
}
