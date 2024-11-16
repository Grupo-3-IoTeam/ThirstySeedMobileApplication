import 'package:flutter/material.dart';

class RegisterNodeScreen extends StatefulWidget {
  const RegisterNodeScreen({super.key});

  @override
  _RegisterNodeScreenState createState() => _RegisterNodeScreenState();
}

class _RegisterNodeScreenState extends State<RegisterNodeScreen> {
  final List<Map<String, TextEditingController>> _nodes = [
    {
      'name': TextEditingController(),
      'type': TextEditingController(),
      'location': TextEditingController(),
    }
  ];
  final ScrollController _scrollController = ScrollController();

  void _addNode() {
    setState(() {
      _nodes.add({
        'name': TextEditingController(),
        'type': TextEditingController(),
        'location': TextEditingController(),
      });
    });

    // Animación para desplazarse al nuevo nodo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 200,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _removeNode(int index) {
    setState(() {
      _nodes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Permite ajustar la pantalla cuando el teclado está activo
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        title: const Text(
          'Node Registration',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nodes: ${_nodes.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: List.generate(_nodes.length, (index) {
                  final node = _nodes[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Stack(
                      children: [
                        Container(
                          width: 280,
                          height: 350, // Ajuste de altura para estirar la tarjeta
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.spa, size: 60, color: Colors.grey),
                              const SizedBox(height: 16.0),
                              _buildTextField(node['name']!, 'Land Name'),
                              const SizedBox(height: 8.0),
                              _buildTextField(node['type']!, 'Node Type'),
                              const SizedBox(height: 8.0),
                              _buildTextField(node['location']!, 'Location'),
                            ],
                          ),
                        ),
                        // Botón de borrar (solo si hay más de un nodo)
                        if (_nodes.length > 1)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => _removeNode(index),
                              child: const Icon(Icons.close, color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 40.0), // Reducir la altura aquí para subir los botones

            // Botón "+" centrado
            Center(
              child: FloatingActionButton(
                onPressed: _addNode,
                backgroundColor: Colors.green,
                child: const Icon(Icons.add, size: 30), // Tamaño del ícono aumentado
              ),
            ),
            const SizedBox(height: 20), // Espacio entre "+" y los botones de guardar/cancelar

            // Botones "Guardar" y "Cancelar"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Acción para guardar los nodos
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  child: const Text('Guardar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.green.withOpacity(0.7)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.green.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}