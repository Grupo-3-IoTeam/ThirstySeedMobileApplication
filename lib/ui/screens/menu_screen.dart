import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'account_screen.dart';
import 'notifications_screen.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thirsty Seed',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
<<<<<<< Updated upstream
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cuenta',
=======
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16.0), // Sin padding lateral
              children: [
                _buildMenuOption(
                  icon: Icons.settings,
                  text: "Administrar parcelas",
                  color: Colors.green,
                  onTap: () {
                    // Agregar funcionalidad para "Administrar parcelas"
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AccountScreen()),
                    );
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
>>>>>>> Stashed changes
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}
