import 'package:flutter/material.dart';
import 'package:thirstyseed/iam/application/auth_service.dart';
import 'package:thirstyseed/iam/presentation/login_screen.dart';
import 'package:thirstyseed/iam/domain/entities/auth_entity.dart';
import 'package:thirstyseed/profile/domain/entities/profile_entity.dart';
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
                    // Lógica para "Administrar parcelas"
                  },
                ),
                _buildMenuOption(
                  icon: Icons.remove_red_eye,
                  text: "Ver estado de parcelas",
                  color: Colors.blue,
                  onTap: () {
                    // Lógica para "Ver estado de parcelas"
                  },
                ),
                _buildMenuOption(
                  icon: Icons.schedule,
                  text: "Riegos programados",
                  color: Colors.teal,
                  onTap: () {
                    // Lógica para "Riegos programados"
                  },
                ),
                _buildMenuOption(
                  icon: Icons.insert_chart,
                  text: "Reportes de riego",
                  color: Colors.orange,
                  onTap: () {
                    // Lógica para "Reportes de riego"
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
  icon: Icons.person,
  text: "Cuenta",
  color: Colors.lightBlue,
  onTap: () {
    final profile = ProfileEntity(
      id: 1, // Usa un ID ficticio o real si lo tienes
      userId: 1, // Asigna un userId si es necesario
      firstName: widget.currentUser.email.split('@')[0], // Ejemplo: usa parte del email como nombre
      lastName: "", // Si no tienes, deja vacío
      email: widget.currentUser.email,
      phoneNumber: "", // Si no tienes datos, asigna un valor vacío
      profileImage: 'https://via.placeholder.com/150', // Imagen por defecto
      location: "Ubicación no registrada",
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountScreen(user: profile),
      ),
    );
  },
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
