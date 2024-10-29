import 'package:flutter/material.dart';

class PlotStatusScreen extends StatelessWidget {
  const PlotStatusScreen({super.key});

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
      body: SingleChildScrollView(
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
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://i.pinimg.com/564x/41/52/e2/4152e208971ee40322e0dffbc94b2436.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Información general de la parcela en un diseño más estilizado
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Terreno',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                ),
                _buildInfoBox('Pucará', width: 170),
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
                _buildInfoBox('100 m2', width: 170),
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
                _buildInfoBox('4', width: 170),
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
                _buildInfoBox('02:45 pm, 15/09', width: 170),
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
                child: const Text('Programar riego'),
              ),
            ),
            const Divider(height: 30),

            // Estado de nodos
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
              children: List.generate(3, (index) {
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
                                'Ubicación: Noreste',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const Text('Humedad: 30%'),
                              const Text('Indicador: Regar'),
                              Text(
                                'Estado: ${index == 1 ? "Error" : "Correcto"}',
                                style: TextStyle(
                                  color: index == 1 ? Colors.red : Colors.green,
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
              }),
            ),

            // Mensaje de error y botón de soporte
            if (true) // Cambia a una condición específica si solo debe mostrarse en caso de error
              Column(
                children: [
                  const SizedBox(height: 10),
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
                      child: const Text('Contactar con soporte'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Widget para cada caja de información estilizada
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
