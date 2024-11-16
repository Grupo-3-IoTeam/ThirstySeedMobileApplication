import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'register_plot_screen.dart';

class PlotScreen extends StatefulWidget {
  const PlotScreen({super.key});

  @override
  _PlotScreenState createState() => _PlotScreenState();
}

class _PlotScreenState extends State<PlotScreen> {
  List<dynamic> _plots = [];
  String _searchText = '';

  // Cargar datos de parcelas desde el backend
  Future<void> loadPlotsData() async {
    final url = Uri.parse('https://thirstyseedapi-production.up.railway.app/api/v1/plot');  // Cambié la URL aquí
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          _plots = jsonData;
        });
      } else {
        throw Exception('Error al cargar datos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener parcelas: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener datos del servidor: $e')),
      );
    }
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
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPlotScreen()),
                  );
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
            Expanded(
              child: ListView(
                children: _plots
                    .where((plot) =>
                plot['name'].toLowerCase().contains(_searchText) ||
                    plot['location'].toLowerCase().contains(_searchText))
                    .map((plot) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          // Imagen
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              plot['imageUrl'] != null && plot['imageUrl'].isNotEmpty
                                  ? plot['imageUrl']
                                  : 'https://via.placeholder.com/150',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;  // Retorna la imagen cuando esté completamente cargada
                                } else {
                                  // Muestra un indicador de progreso mientras la imagen se carga
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                // Si ocurre un error al cargar la imagen, muestra una imagen de reemplazo
                                return Image.network('https://via.placeholder.com/150');
                              },
                            ),
                          ),
                          const SizedBox(width: 16.0),

                          // Expansión de los textos
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
                }).toList(),
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
                plot['imageUrl'] != null && plot['imageUrl'].isNotEmpty
                    ? plot['imageUrl']
                    : 'https://via.placeholder.com/150',  // Usa una imagen por defecto si la URL es inválida o vacía
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;  // Retorna la imagen cuando esté completamente cargada
                  } else {
                    // Muestra un indicador de progreso mientras la imagen se carga
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  // Si ocurre un error al cargar la imagen, muestra una imagen de reemplazo
                  return Image.network('https://i.pinimg.com/736x/27/7f/5d/277f5df2d275cf76a7051a2e93fddd7f.jpg');
                },
              ),
            ),
            const SizedBox(width: 16.0),
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