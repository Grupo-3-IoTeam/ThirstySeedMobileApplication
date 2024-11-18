import 'package:flutter/material.dart';
import 'package:thirstyseed/iam/application/auth_service.dart';
import 'package:thirstyseed/iam/presentation/login_screen.dart';
import 'package:thirstyseed/profile/domain/entities/profile_entity.dart';

class AccountScreen extends StatelessWidget {
  final ProfileEntityGet user;
  final AuthService authService;

  const AccountScreen({Key? key, required this.user, required this.authService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.green[100],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.profileImage),
            ),
            const SizedBox(height: 16.0),
            _buildProfileInfoRow(icon: Icons.person, text: user.fullName),
            _buildProfileInfoRow(icon: Icons.phone, text: user.phoneNumber),
            _buildProfileInfoRow(icon: Icons.email, text: user.email),
            _buildProfileInfoRow(icon: Icons.location_on, text: user.location),
            const SizedBox(height: 20.0),
            _buildSectionHeader(icon: Icons.agriculture, title: "Parcelas registradas"),
            const SizedBox(height: 20.0),
            _buildSectionHeader(icon: Icons.water_drop, title: "Proveedor de agua"),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(authService: authService),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 182, 48, 25),
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Salir', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

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
}
