import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../irrigation/presentation/register_node_screen.dart';

class RegisterPlotScreen extends StatefulWidget {
  const RegisterPlotScreen({super.key});

  @override
  _RegisterPlotScreenState createState() => _RegisterPlotScreenState();
}

class _RegisterPlotScreenState extends State<RegisterPlotScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _extensionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  String? _imageUrl;

  Future<void> _registerPlot() async {
    final url = Uri.parse('http://10.0.2.2:8080/plots/createPlot');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': _nameController.text,
          'location': _locationController.text,
          'extension': _extensionController.text,
          'imageUrl': _imageUrlController.text, // Añadir la URL de la imagen al cuerpo de la solicitud
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Parcela registrada con éxito')),
        );
      } else {
        throw Exception('Error al registrar parcela');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _updateImagePreview() {
    setState(() {
      _imageUrl = _imageUrlController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        title: const Text(
          'Registrar parcela',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'URL de la Imagen',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _imageUrlController,
              onChanged: (_) => _updateImagePreview(),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Ingrese la URL de la imagen',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_imageUrl != null && _imageUrl!.isNotEmpty)
              Center(
                child: Image.network(
                  _imageUrl!,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text(
                      'No se pudo cargar la imagen',
                      style: TextStyle(color: Colors.red),
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),
            const Text(
              'Nombre de Terreno',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Nombre De Terreno',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ubicación',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _locationController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Ubicación',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Extensión',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _extensionController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Extensión',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _registerPlot,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Registrar Parcela',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
