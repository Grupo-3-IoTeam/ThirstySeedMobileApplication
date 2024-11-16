import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPlotScreen extends StatefulWidget {
  const RegisterPlotScreen({super.key});

  @override
  _RegisterPlotScreenState createState() => _RegisterPlotScreenState();
}

class _RegisterPlotScreenState extends State<RegisterPlotScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _extensionController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();  // Nuevo controlador para size
  final TextEditingController _imageUrlController = TextEditingController();

  String? _imageUrl;
  bool _isImageLoading = false;  // Controla el estado de carga de la imagen

  Future<void> _registerPlot() async {
    final url = Uri.parse('https://thirstyseedapi-production.up.railway.app/api/v1/plot');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': 1,
          'name': _nameController.text.trim(),
          'location': _locationController.text.trim(),
          'extension': int.tryParse(_extensionController.text) ?? 0,
          'size': int.tryParse(_sizeController.text) ?? 0,
          'imageUrl': _imageUrlController.text.trim(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Parcela registrada con éxito')),
        );
      } else {
        throw Exception('Error al registrar parcela: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


  // Método para actualizar la imagen previa
  void _updateImagePreview() {
    final url = _imageUrlController.text.trim();
    setState(() {
      _isImageLoading = true;

      // Valida que sea un enlace con "http" o "https".
      if (url.isNotEmpty && (url.startsWith('http://') || url.startsWith('https://'))) {
        _imageUrl = url;
      } else {
        _imageUrl = null;
      }
      _isImageLoading = false;
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
            if (_isImageLoading)
              const Center(child: CircularProgressIndicator())  // Indicador de carga mientras se carga la imagen
            else if (_imageUrl != null && _imageUrl!.isNotEmpty)
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
              )
            else
              const Center(child: Text('Imagen no disponible o URL incorrecta')),
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
            const SizedBox(height: 20),
            const Text(
              'Tamaño (Size)',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _sizeController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Tamaño de la parcela',
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
