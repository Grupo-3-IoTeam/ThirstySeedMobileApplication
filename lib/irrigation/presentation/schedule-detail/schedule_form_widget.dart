import 'package:flutter/material.dart';
import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';

class ScheduleFormWidget extends StatefulWidget {
  final ScheduleModel schedule;

  const ScheduleFormWidget({super.key, required this.schedule});

  @override
  _ScheduleFormWidgetState createState() => _ScheduleFormWidgetState();
}

class _ScheduleFormWidgetState extends State<ScheduleFormWidget> {
  late TextEditingController waterAmountController;
  late TextEditingController pressureController;
  late TextEditingController sprinklerRadiusController;
  late TextEditingController setTimeController;

  @override
  void initState() {
    super.initState();
    waterAmountController = TextEditingController(text: widget.schedule.waterAmount.toString());
    pressureController = TextEditingController(text: widget.schedule.pressure.toString());
    sprinklerRadiusController = TextEditingController(text: widget.schedule.sprinklerRadius.toString());
    setTimeController = TextEditingController(text: widget.schedule.setTime);
  }

  @override
  void dispose() {
    waterAmountController.dispose();
    pressureController.dispose();
    sprinklerRadiusController.dispose();
    setTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: waterAmountController,
            decoration: const InputDecoration(labelText: 'Cantidad de Agua (L)'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: pressureController,
            decoration: const InputDecoration(labelText: 'Presión (PSI)'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: sprinklerRadiusController,
            decoration: const InputDecoration(labelText: 'Radio del Aspersor (m)'),
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            controller: setTimeController,
            decoration: const InputDecoration(labelText: 'Hora de Riego (hh:mm)'),
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Aquí puedes implementar la lógica para actualizar el modelo
              final updatedSchedule = ScheduleModel(
                id: widget.schedule.id,
                plotId: widget.schedule.plotId,
                waterAmount: double.parse(waterAmountController.text),
                pressure: double.parse(pressureController.text),
                sprinklerRadius: double.parse(sprinklerRadiusController.text),
                expectedMoisture: widget.schedule.expectedMoisture,
                estimatedTimeHours: widget.schedule.estimatedTimeHours,
                setTime: setTimeController.text,
                angle: widget.schedule.angle,
                isAutomatic: widget.schedule.isAutomatic,
              );
              
              // Puedes llamar al Bloc para actualizar el estado si es necesario
              Navigator.of(context).pop(updatedSchedule);
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }
}
