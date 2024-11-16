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
      // Convierte valores a enteros si es posible, de lo contrario usa double.
      final waterAmount = double.parse(waterAmountController.text).toInt();
      final pressure = double.parse(pressureController.text).toInt();
      final sprinklerRadius = double.parse(sprinklerRadiusController.text).toInt();
      final expectedMoisture = double.parse(expectedMoistureController.text).toInt();

      final newSchedule = ScheduleModel(
        id: 1, // ID de prueba
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
            _buildTextField("Cantidad de Agua (L)", waterAmountController),
            _buildTextField("Presión (PSI)", pressureController),
            _buildTextField("Radio del Aspersor (m)", sprinklerRadiusController),
            _buildTextField("Hora de Riego (hh:mm a)", setTimeController, isTime: false),
            _buildTextField("Humedad Esperada (%)", expectedMoistureController),
            _buildTextField("Tiempo Estimado (Horas)", estimatedTimeHoursController),
            _buildTextField("Ángulo del Aspersor", angleController),
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

  Widget _buildTextField(String label, TextEditingController controller, {bool isTime = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: isTime ? TextInputType.text : TextInputType.number, // Cambiado a TextInputType.text para texto y números
    );
  }
}