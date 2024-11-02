import 'package:flutter/material.dart';
import 'injections.dart';
import 'ui/screens/menu_screen.dart';
import 'package:thirstyseed/irrigation/presentation/schedule-list/schedule_list_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thirsty Seed',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MenuScreen(),
      routes: {
        '/scheduleList': (context) => const ScheduleListScreen(),
      },
    );
  }
}