import 'package:flutter/material.dart';
import 'package:thirstyseed/irrigation/domain/entities/schedule.dart';

class ScheduleItemWidget extends StatelessWidget {
  final Schedule schedule;

  const ScheduleItemWidget({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(
          schedule.isAutomatic ? Icons.autorenew : Icons.handyman,
          color: schedule.isAutomatic ? Colors.blue : Colors.green,
        ),
        title: Text('Plot ID: ${schedule.plotId}'),
        subtitle: Text('Water Amount: ${schedule.waterAmount} L'),
        trailing: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            // Navegar a los detalles del schedule
            
          },
        ),
      ),
    );
  }
}