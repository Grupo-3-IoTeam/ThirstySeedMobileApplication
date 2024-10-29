import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

class PlotScreen extends StatefulWidget {
  const PlotScreen({super.key});

  @override
  _PlotScreenState createState() => _PlotScreenState();
}

class _PlotScreenState extends State<PlotScreen> {
  List<dynamic> _plots = [];
  String _searchText = '';

  // Cargar datos de parcelas desde un archivo JSON
  Future<void> loadPlotsData() async {
    final String jsonString = await rootBundle.rootBundle.loadString('server/db.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    setState(() {
      _plots = jsonData['plots'];
    });
  }

  @override
  void initState() {
    super.initState();
    loadPlotsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registered Plots',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[100],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barra de búsqueda
            TextField(
              onChanged: (text) {
                setState(() {
                  _searchText = text.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.green[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            
            const SizedBox(height: 10.0),
            
            // Botón "Registrar Parcela" alineado a la derecha
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Acción para registrar parcela
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Registrar Parcela",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),

            const SizedBox(height: 16.0),
            
            // Lista de parcelas filtrada
            Expanded(
              child: ListView(
                children: _plots
                    .where((plot) =>
                        plot['name'].toLowerCase().contains(_searchText) ||
                        plot['location'].toLowerCase().contains(_searchText))
                    .map((plot) => PlotCard(plot: plot))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlotCard extends StatelessWidget {
  final Map<String, dynamic> plot;

  const PlotCard({Key? key, required this.plot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                plot['imageUrl'],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            // Información de la parcela
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Land Name: ${plot['name']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Location: ${plot['location']}'),
                  Text('Extension of Land: ${plot['extension']} m2'),
                  Text('Plot Status: ${plot['status']}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
