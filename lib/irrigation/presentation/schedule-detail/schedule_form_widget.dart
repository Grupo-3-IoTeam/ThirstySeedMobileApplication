import 'package:flutter/material.dart';
import 'package:thirstyseed/irrigation/infrastructure/data_sources/schedule_remote_data_provider.dart';
import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';

class ScheduleFormWidget extends StatefulWidget {
  final ScheduleModel schedule;

  const ScheduleFormWidget({super.key, required this.schedule});

  @override
  _ScheduleFormWidgetState createState() => _ScheduleFormWidgetState();
}

class _ScheduleFormWidgetState extends State<ScheduleFormWidget> {
  TextEditingController waterAmountController;
  TextEditingController pressureController;
  TextEditingController sprinklerRadiusController;
  TextEditingController setTimeController;
  TextEditingController expectedMoistureController;
  TextEditingController estimatedTimeHoursController;
  TextEditingController angleController;
  bool isAutomatic;
  final ScheduleRemoteDataProvider scheduleRemoteDataProvider = ScheduleRemoteDataProvider();

  _ScheduleFormWidgetState()
      : waterAmountController = TextEditingController(),
        pressureController = TextEditingController(),
        sprinklerRadiusController = TextEditingController(),
        setTimeController = TextEditingController(),
        expectedMoistureController = TextEditingController(),
        estimatedTimeHoursController = TextEditingController(),
        angleController = TextEditingController(),
        isAutomatic = false;

  @override
  void initState() {
    super.initState();
    waterAmountController.text = widget.schedule.waterAmount.toString();
    pressureController.text = widget.schedule.pressure.toString();
    sprinklerRadiusController.text = widget.schedule.sprinklerRadius.toString();
    setTimeController.text = widget.schedule.setTime;
    expectedMoistureController.text = widget.schedule.expectedMoisture.toString();
    estimatedTimeHoursController.text = widget.schedule.estimatedTimeHours.toString();
    angleController.text = widget.schedule.angle.toString();
    isAutomatic = widget.schedule.isAutomatic;
  }

  @override
  void dispose() {
    waterAmountController.dispose();
    pressureController.dispose();
    sprinklerRadiusController.dispose();
    setTimeController.dispose();
    expectedMoistureController.dispose();
    estimatedTimeHoursController.dispose();
    angleController.dispose();
    super.dispose();
  }

  Future<void> saveSchedule() async {
    try {
      final waterAmount = int.parse(waterAmountController.text);
      final pressure = int.parse(pressureController.text);
      final sprinklerRadius = int.parse(sprinklerRadiusController.text);
      final expectedMoisture = int.parse(expectedMoistureController.text);

      final newSchedule = ScheduleModel(
        id: 2, // ID de prueba
        plotId: 1, // plotId de prueba
        waterAmount: waterAmount,
        pressure: pressure,
        sprinklerRadius: sprinklerRadius,
        expectedMoisture: expectedMoisture,
        estimatedTimeHours: int.parse(estimatedTimeHoursController.text),
        setTime: setTimeController.text,
        angle: int.parse(angleController.text),
        isAutomatic: isAutomatic,
      );

      final createdSchedule = await scheduleRemoteDataProvider.createSchedule(newSchedule);
      print("Schedule created successfully: ${createdSchedule.toJson()}");

      Navigator.of(context).pop(createdSchedule);
    } catch (e) {
      print("Error al guardar el schedule: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar el schedule: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField("Cantidad de Agua (L)", waterAmountController, isNumeric: true),
            _buildTextField("Presión (PSI)", pressureController, isNumeric: true),
            _buildTextField("Radio del Aspersor (m)", sprinklerRadiusController, isNumeric: true),
            _buildTextField("Hora de Riego (hh:mm a)", setTimeController), // Permitir texto libre para el campo de hora
            _buildTextField("Humedad Esperada (%)", expectedMoistureController, isNumeric: true),
            _buildTextField("Tiempo Estimado (Horas)", estimatedTimeHoursController, isNumeric: true),
            _buildTextField("Ángulo del Aspersor", angleController, isNumeric: true),
            SwitchListTile(
              title: const Text('Modo Automático'),
              value: isAutomatic,
              onChanged: (value) {
                setState(() {
                  isAutomatic = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveSchedule,
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text, // Permitir texto y números en setTime
    );
  }
}