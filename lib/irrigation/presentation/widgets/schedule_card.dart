import 'package:flutter/material.dart';
import 'package:thirstyseed/irrigation/domain/entities/schedule.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ScheduleCard({
    super.key,
    required this.schedule,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Plot ID: ${schedule.plotId}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Water Amount: ${schedule.waterAmount} liters'),
            Text('Pressure: ${schedule.pressure} PSI'),
            Text('Sprinkler Radius: ${schedule.sprinklerRadius} m'),
            Text('Moisture Level: ${schedule.expectedMoisture}'),
            Text('Time: ${schedule.setTime}'),
            Text('Mode: ${schedule.isAutomatic ? "Automatic" : "Manual"}'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                  tooltip: 'Edit Schedule',
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                  tooltip: 'Delete Schedule',
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}