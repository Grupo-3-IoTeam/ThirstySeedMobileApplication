import 'package:flutter/material.dart';
import 'package:thirstyseed/profile/domain/entities/plot_entity.dart';
import '../../iam/domain/entities/user_entity.dart';

class AccountScreen extends StatelessWidget {
  final User user;

  const AccountScreen({Key? key, required this.user}) : super(key: key);

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
              backgroundImage: NetworkImage(user.imageUrl),
            ),
            const SizedBox(height: 16.0),
            _buildProfileInfoRow(icon: Icons.person, text: user.name),
            _buildProfileInfoRow(icon: Icons.phone, text: user.telephone),
            _buildProfileInfoRow(icon: Icons.email, text: user.email),
            _buildProfileInfoRow(icon: Icons.location_on, text: user.city),
            const SizedBox(height: 20.0),
            _buildSectionHeader(icon: Icons.agriculture, title: "Parcelas registradas"),
            ...List.generate(user.plots.length, (index) {
              final plot = user.plots[index];
              return _buildPlotCard(plot);
            }),
            const SizedBox(height: 20.0),
            _buildSectionHeader(icon: Icons.water_drop, title: "Proveedor de agua"),
            const SizedBox(height: 10.0),
            Image.network(user.waterSupplier.logo, height: 100),
            const SizedBox(height: 10.0),
            Text(
              user.waterSupplier.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
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
            plot.imageUrl,
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
