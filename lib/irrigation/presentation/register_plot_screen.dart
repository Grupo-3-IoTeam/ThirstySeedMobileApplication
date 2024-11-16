import '../infrastructure/models/plot_model.dart';
import '../domain/logic/plot_controller.dart';
import 'package:flutter/material.dart';
import '../infrastructure/repositories/plot_repository.dart';

class RegisterPlotScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _extensionController = TextEditingController();

  final PlotController controller = PlotController(PlotRepository()); // Pasar PlotRepository

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Parcela'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Ubicación'),
            ),
            TextField(
              controller: _extensionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Extensión'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final plot = PlotModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _nameController.text,
                  location: _locationController.text,
                  extension: double.tryParse(_extensionController.text) ?? 0.0,
                  imageUrl:
                  'https://definicion.de/wp-content/uploads/2010/07/parcela-1.jpg',
                );

                controller.savePlot(plot).then((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Parcela registrada con éxito')),
                  );
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $error')),
                  );
                });
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
