import 'package:flutter/material.dart';

class RegisterPlotScreen extends StatefulWidget {
  const RegisterPlotScreen({super.key});

  @override
  _RegisterPlotScreenState createState() => _RegisterPlotScreenState();
}

class _RegisterPlotScreenState extends State<RegisterPlotScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _extensionController = TextEditingController();

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
            // Imagen de Parcela
            Center(
              child: GestureDetector(
                onTap: () {
                  // Acción para seleccionar imagen
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://definicion.de/wp-content/uploads/2010/07/parcela-1.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Insertar Imagen',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Campos de texto para los detalles de la parcela
            const Text(
              'Nombre de Terreno',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.black), // Texto ingresado en negro
              decoration: InputDecoration(
                hintText: 'Nombre De Terreno',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)), // Placeholder sutil
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),

            const Text(
              'Ubicación',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _locationController,
              style: const TextStyle(color: Colors.black), // Texto ingresado en negro
              decoration: InputDecoration(
                hintText: 'Ubicación',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)), // Placeholder sutil
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),

            const Text(
              'Extensión de Terreno',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _extensionController,
              style: const TextStyle(color: Colors.black), // Texto ingresado en negro
              decoration: InputDecoration(
                hintText: 'Extensión De Terreno',
                hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)), // Placeholder sutil
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Botón de "Registrar nodos"
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción para registrar nodos
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'Siguiente',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
