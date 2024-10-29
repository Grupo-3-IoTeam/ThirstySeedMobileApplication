import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  Future<Map<String, dynamic>> loadUserData() async {
    final String jsonString = await rootBundle.rootBundle.loadString('server/db.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return jsonData['user'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.green[100],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No hay datos disponibles'));
          }

          final user = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Imagen de perfil
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user['profileImage']),
                ),
                const SizedBox(height: 16.0),

                // Información del perfil
                ProfileInfoRow(
                  icon: Icons.person,
                  text: user['name'],
                  color: Colors.green[100],
                ),
                ProfileInfoRow(
                  icon: Icons.phone,
                  text: user['phone'],
                  color: Colors.green[100],
                ),
                ProfileInfoRow(
                  icon: Icons.email,
                  text: user['email'],
                  color: Colors.green[100],
                ),
                ProfileInfoRow(
                  icon: Icons.location_on,
                  text: user['location'],
                  color: Colors.green[100],
                ),

                // Sección de parcelas registradas con nuevo estilo
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.agriculture, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text(
                          "Parcelas registradas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Acción para ver más parcelas
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: const Text("Ver más", style: TextStyle(color: Colors.white, fontSize: 9)),
                    ),
                  ],
                ),
                const Divider(color: Colors.green),
                const SizedBox(height: 10),

                // Mostrar parcelas del usuario
                ...List.generate(user['plots'].length, (index) {
                  final plot = user['plots'][index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          plot['image'],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(plot['name']),
                    ),
                  );
                }),

                // Espacio entre secciones
                const SizedBox(height: 20.0),

                // Sección de proveedor de agua
                Row(
                  children: [
                    Icon(Icons.water_drop, color: Colors.green),
                    const SizedBox(width: 8),
                    const Text(
                      "Proveedor de agua",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
                ),
                const Divider(color: Colors.green),
                const SizedBox(height: 10),

                // Logotipo del proveedor de agua
                Image.network(
                  user['waterSupplier']['logo'],
                  height: 100,
                ),
                const SizedBox(height: 20),

                // Botones Guardar y Cancelar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Acción de guardar
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text("Guardar"),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Acción de cancelar
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text("Cancelar"),
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
}

// Widget reutilizable para mostrar la información del perfil
class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  const ProfileInfoRow({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
