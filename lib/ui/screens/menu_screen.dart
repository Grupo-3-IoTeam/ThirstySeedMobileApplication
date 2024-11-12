import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'account_screen.dart';
import 'notifications_screen.dart';
import '../plots/presentation/plot_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    NotificationsScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Encabezado personalizado que abarca toda la pantalla
          Container(
            width: double.infinity, // Ancho completo
            color: Colors.green[100],
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.eco, // Icono de Flutter
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
              padding: const EdgeInsets.symmetric(vertical: 16.0), // Sin padding lateral
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
                    // Agregar funcionalidad para "Ver estado de parcelas"
                  },
                ),
                _buildMenuOption(
                  icon: Icons.schedule,
                  text: "Riegos programados",
                  color: Colors.teal,
                  onTap: () {
                    // Agregar funcionalidad para "Riegos programados"
                  },
                ),
                _buildMenuOption(
                  icon: Icons.insert_chart,
                  text: "Reportes de riego",
                  color: Colors.orange,
                  onTap: () {
                    // Agregar funcionalidad para "Reportes de riego"
                  },
                ),
                _buildMenuOption(
                  icon: Icons.notifications,
                  text: "Notificaciones",
                  color: Colors.amber,
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                ),
                _buildMenuOption(
                  icon: Icons.person,
                  text: "Cuenta",
                  color: Colors.lightBlue,
                  onTap: () {
                    // Navegar a AccountScreen
                    
                  },
                ),
                const SizedBox(height: 70.0),
                _buildMenuOption(
                  icon: Icons.exit_to_app,
                  text: "Salir",
                  color: Colors.blueAccent,
                  onTap: () {
                    // Agregar funcionalidad para salir de la app
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
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