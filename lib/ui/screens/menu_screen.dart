import 'package:flutter/material.dart';
import 'package:thirstyseed/iam/application/auth_service.dart';
import 'package:thirstyseed/iam/domain/entities/auth_entity.dart';
import 'package:thirstyseed/irrigation/application/plot_service.dart';
import 'package:thirstyseed/irrigation/application/schedule_service.dart';
import 'package:thirstyseed/irrigation/infrastructure/data_sources/plot_data_source.dart';
import 'package:thirstyseed/irrigation/infrastructure/data_sources/schedule_data_source.dart';
import 'package:thirstyseed/irrigation/infrastructure/repositories/plot_repository.dart';
import 'package:thirstyseed/irrigation/infrastructure/repositories/schedule_repository.dart';
import 'package:thirstyseed/irrigation/presentation/plot_screen.dart';
import 'package:thirstyseed/irrigation/presentation/plot_status_screen.dart';
import 'package:thirstyseed/irrigation/presentation/schedule/schedule_list_screen.dart';
import 'package:thirstyseed/profile/domain/entities/profile_entity.dart';
import 'package:thirstyseed/profile/infrastructure/data_sources/profile_data_source.dart';
import 'package:thirstyseed/profile/presentation/view_account_profile.dart';

class MenuScreen extends StatefulWidget {
  final AuthService authService;
  final UserAuth currentUser;

  const MenuScreen({super.key, required this.authService, required this.currentUser});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  Future<ProfileEntity?> _fetchUserProfile(int userId) async {
    final profileDataSource = ProfileDataSource();
    try {
      return await profileDataSource.getProfileByUserId(userId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al obtener el perfil: $e')),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.green[100],
              padding: const EdgeInsets.only(top: 60.0, bottom: 16.0, left: 16.0, right: 16.0), // Adjusted padding to move the header down further
              child: const Row(
                children: [
                  Icon(
                    Icons.eco,
                    color: Colors.green,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Thirsty Seed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16.0),
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildMenuCard(
                    icon: Icons.settings,
                    text: "Administrar parcelas",
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlotScreen(userId: widget.currentUser.id)),
                      );
                    },
                  ),
                  _buildMenuCard(
                    icon: Icons.remove_red_eye,
                    text: "Ver estado de parcelas",
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlotStatusScreen(userId: widget.currentUser.id),
                        ),
                      );
                    },
                  ),
                  _buildMenuCard(
                    icon: Icons.schedule,
                    text: "Riegos programados",
                    color: Colors.teal,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          final plotDataSource = PlotDataSource();
                          final plotRepository = PlotRepository(dataSource: plotDataSource);
                          final plotService = PlotService(repository: plotRepository);
                          final scheduleDataSource = ScheduleDataSource();
                          final scheduleRepository = ScheduleRepository(dataSource: scheduleDataSource);
                          final scheduleService = ScheduleService(repository: scheduleRepository);
                          return ScheduleListScreen(scheduleService: scheduleService, plotService: plotService);
                        }),
                      );
                    },
                  ),
                  _buildMenuCard(
                    icon: Icons.person,
                    text: "Ver Perfil",
                    color: Colors.green,
                    onTap: () async {
                      final userId = widget.currentUser.id;
                      final profile = await _fetchUserProfile(userId);
                      if (profile != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountScreen(user: profile, authService: widget.authService),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.network(
                    'https://media.tenor.com/mVb37LRHswIAAAAM/shae-waving.gif',
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '¡Hola! Comienza con alguna de las opciones para cuidar tus forrajes y programar el riego.',
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 50),
              const SizedBox(height: 16),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
