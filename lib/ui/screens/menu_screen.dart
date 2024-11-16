import 'package:flutter/material.dart';
import 'package:thirstyseed/iam/application/auth_service.dart';
import 'package:thirstyseed/iam/presentation/login_screen.dart';
import 'package:thirstyseed/iam/domain/entities/auth_entity.dart';
import 'package:thirstyseed/irrigation/domain/entities/node_entity.dart';
import 'package:thirstyseed/irrigation/domain/entities/plot_entity.dart';
import 'package:thirstyseed/irrigation/presentation/plot_screen.dart';
import 'package:thirstyseed/irrigation/presentation/plot_status_screen.dart';
import 'package:thirstyseed/profile/domain/entities/profile_entity.dart';
import 'package:thirstyseed/profile/infrastructure/data_sources/profile_data_source.dart';
import 'package:thirstyseed/profile/presentation/view_account_profile.dart';


class MenuScreen extends StatefulWidget {
  final AuthService authService;
  final UserAuth currentUser;

  const MenuScreen({Key? key, required this.authService, required this.currentUser}) : super(key: key);

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

Future<ProfileEntity?> _fetchUserProfile(int userId) async {
    final profileDataSource = ProfileDataSource();
    try {
      return await profileDataSource.getProfileByUserId(userId);
    } catch (e) {
      // Manejo de errores
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener el perfil: $e')),
      );
      return null;
    }
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Esto evita que la app se cierre al retroceder
        return false;
      },
      child: Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.green[100],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.eco,
                  color: Colors.green,
                  size: 40,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Thirsty Seed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              children: [
                _buildMenuOption(
                  icon: Icons.settings,
                  text: "Administrar parcelas",
                  color: Colors.green,
                  onTap: () {
                     // Navegar a AccountScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PlotScreen()),
                    );
                  },
                ),
                _buildMenuOption(
                  icon: Icons.remove_red_eye,
                  text: "Ver estado de parcelas",
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlotStatusScreen(
          fetchPlots: () async => [
            Plot(
              id: 1,
              name: 'Parcela de Prueba',
              extension: 1200,
              installedNodes: 5,
              lastIrrigationDate: '2024-11-15',
              imageUrl: 'https://via.placeholder.com/150',
              location: 'Ubicación no registrada',
              status: 'OK',
              size: 5,
              nodes: [
                Node(
                  location: 'Sector 1',
                  moisture: 50,
                  indicator: 'Normal',
                  status: 'OK',
                ),
                Node(
                  location: 'Sector 2',
                  moisture: 45,
                  indicator: 'Normal',
                  status: 'Error',
                ),
              ],
            ),
          ],
        ),
      ),
    );
                  },
                ),
                _buildMenuOption(
                  icon: Icons.schedule,
                  text: "Riegos programados",
                  color: Colors.teal,
                  onTap: () {
                    Navigator.pushNamed(context, '/scheduleList');
                  },
                ),
                _buildMenuOption(
                  icon: Icons.insert_chart,
                  text: "Reportes de riego",
                  color: Colors.orange,
                  onTap: () {
                    
                  },
                ),
                _buildMenuOption(
                  icon: Icons.notifications,
                  text: "Notificaciones",
                  color: Colors.amber,
                  onTap: () {
                    // Lógica para "Notificaciones"
                  },
                ),
               _buildMenuOption(
  icon: Icons.person, // Un icono adecuado para ver el perfil
  text: "Ver Perfil",
  color: Colors.green,
  onTap: () async {
                    final userId = widget.currentUser.id; // Obtén el ID del usuario actual
                    final profile = await _fetchUserProfile(userId);
                    if (profile != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountScreen(user: profile),
                        ),
                      );
                    }
  }
),
                const SizedBox(height: 70.0),
                _buildMenuOption(
                  icon: Icons.exit_to_app,
                  text: "Salir",
                  color: Colors.blueAccent,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(authService: widget.authService),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }
}
