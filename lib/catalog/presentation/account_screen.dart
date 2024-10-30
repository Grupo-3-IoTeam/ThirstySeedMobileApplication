import 'package:flutter/material.dart';
import '../application/fetch_user_profile.dart';
import '../domain/entities/plot_entity.dart';
import '../domain/entities/user_entity.dart';

class AccountScreen extends StatelessWidget {
  final FetchUserProfile fetchUserProfile;

  const AccountScreen({super.key, required this.fetchUserProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.green[100],
      ),
      body: FutureBuilder<User>(
        future: fetchUserProfile(), // Ajuste para trabajar con Future<User>
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
                  backgroundImage: NetworkImage(user.profileImage),
                ),
                const SizedBox(height: 16.0),

                // Información del perfil
                _buildProfileInfoRow(icon: Icons.person, text: user.name),
                _buildProfileInfoRow(icon: Icons.phone, text: user.phone),
                _buildProfileInfoRow(icon: Icons.email, text: user.email),
                _buildProfileInfoRow(icon: Icons.location_on, text: user.location),
                
                const SizedBox(height: 20.0),

                // Sección de parcelas registradas
                _buildSectionHeader(
                  icon: Icons.agriculture,
                  title: "Parcelas registradas",
                ),
                ...List.generate(user.plots.length, (index) {
                  final plot = user.plots[index];
                  return _buildPlotCard(plot);
                }),

                const SizedBox(height: 20.0),

                // Sección de proveedor de agua
                _buildSectionHeader(
                  icon: Icons.water_drop,
                  title: "Proveedor de agua",
                ),
                const SizedBox(height: 10.0),
                Image.network(
                  user.waterSupplier.logo,
                  height: 100,
                ),
                const SizedBox(height: 10.0),
                Text(
                  user.waterSupplier.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 20.0),

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

  // Método auxiliar para construir una fila de información del perfil
  Widget _buildProfileInfoRow({required IconData icon, required String text}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
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

  // Método auxiliar para construir un encabezado de sección
  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  // Método auxiliar para construir una tarjeta de parcela
  Widget _buildPlotCard(Plot plot) {
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
            plot.image,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(plot.name),
      ),
    );
  }
}
