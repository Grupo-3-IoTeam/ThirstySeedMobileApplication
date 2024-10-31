import 'package:flutter/material.dart';
import 'package:thirstyseed/iam/application/auth_service.dart';
import 'package:thirstyseed/iam/presentation/login_screen.dart';


class MenuScreen extends StatefulWidget {
  final AuthService authService;

  const MenuScreen({Key? key, required this.authService}) : super(key: key);

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onTap: () {},
                ),
                _buildMenuOption(
                  icon: Icons.remove_red_eye,
                  text: "Ver estado de parcelas",
                  color: Colors.blue,
                  onTap: () {},
                ),
                _buildMenuOption(
                  icon: Icons.schedule,
                  text: "Riegos programados",
                  color: Colors.teal,
                  onTap: () {},
                ),
                _buildMenuOption(
                  icon: Icons.insert_chart,
                  text: "Reportes de riego",
                  color: Colors.orange,
                  onTap: () {},
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
                  onTap: () {},
                ),
                const SizedBox(height: 70.0),
                _buildMenuOption(
                  icon: Icons.exit_to_app,
                  text: "Salir",
                  color: Colors.blueAccent,
                  onTap: () {
                    // Navega de vuelta a la pantalla de login
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
