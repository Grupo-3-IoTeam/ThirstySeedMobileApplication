import 'package:flutter/material.dart';
import 'package:thirstyseed/irrigation/domain/entities/schedule_entity.dart';
import 'package:thirstyseed/irrigation/application/schedule_service.dart';
import 'package:thirstyseed/irrigation/application/plot_service.dart';
import 'add_schedule_screen.dart';

class ScheduleListScreen extends StatefulWidget {
  final ScheduleService scheduleService;
  final PlotService plotService;

  const ScheduleListScreen({Key? key, required this.scheduleService, required this.plotService}) : super(key: key);

  @override
  _ScheduleListScreenState createState() => _ScheduleListScreenState();
}

class _ScheduleListScreenState extends State<ScheduleListScreen> {
  late Future<List<Schedule>> _schedulesFuture;

  @override
  void initState() {
    super.initState();
    _schedulesFuture = widget.scheduleService.getSchedulesByUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedules'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Schedule>>(
        future: _schedulesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No schedules found'));
          } else {
            final schedules = snapshot.data!;
            return ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final schedule = schedules[index];
                return ListTile(
                  title: Text('Plot ID: ${schedule.plotId}, Time: ${schedule.setTime}'),
                  subtitle: Text('Automatic: ${schedule.isAutomatic ? 'Yes' : 'No'}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddScheduleScreen(
                                scheduleService: widget.scheduleService,
                                plotService: widget.plotService,
                                schedule: schedule,
                              ),
                            ),
                          ).then((_) {
                            setState(() {
                              _schedulesFuture = widget.scheduleService.getSchedulesByUserId();
                            });
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await widget.scheduleService.deleteSchedule(schedule.id);
                          setState(() {
                            _schedulesFuture = widget.scheduleService.getSchedulesByUserId();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScheduleScreen(
                scheduleService: widget.scheduleService,
                plotService: widget.plotService,
              ),
            ),
          ).then((_) {
            setState(() {
              _schedulesFuture = widget.scheduleService.getSchedulesByUserId();
            });
          });
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
