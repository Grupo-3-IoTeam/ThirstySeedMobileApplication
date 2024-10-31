import 'package:flutter/material.dart';
import 'ui/screens/menu_screen.dart';
import 'iam/presentation/login_screen.dart';
import 'iam/application/auth_service.dart';
import 'iam/infrastructure/data_sources/user_data_source.dart';

void main() {
  final authService = AuthService(dataSource: UserDataSource());
  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Desactiva el banner de debug
      title: 'Thirsty Seed',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: LoginScreen(authService: authService),
    );
  }
}

