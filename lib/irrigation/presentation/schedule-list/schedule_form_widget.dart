import 'package:flutter/material.dart';
import 'package:thirstyseed/injections.dart';
import 'package:thirstyseed/irrigation/application/schedule_facade_service.dart';
import 'package:thirstyseed/irrigation/infrastructure/models/schedule_model.dart';

class ScheduleFormWidget extends StatefulWidget {
  final ScheduleModel? schedule;

  const ScheduleFormWidget({super.key, this.schedule});

  @override
  _ScheduleFormWidgetState createState() => _ScheduleFormWidgetState();
}

class _ScheduleFormWidgetState extends State<ScheduleFormWidget> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _plotIdController;
  late final TextEditingController _waterAmountController;
  late final TextEditingController _pressureController;
  late final TextEditingController _sprinklerRadiusController;
  late final TextEditingController _expectedMoistureController;
  late final TextEditingController _estimatedTimeHoursController;
  late final TextEditingController _setTimeController;
  late final TextEditingController _angleController;
  late bool _isAutomatic;

  @override
  void initState() {
    super.initState();
    _plotIdController = TextEditingController(text: widget.schedule?.plotId ?? '');
    _waterAmountController = TextEditingController(text: widget.schedule?.waterAmount.toString() ?? '');
    _pressureController = TextEditingController(text: widget.schedule?.pressure.toString() ?? '');
    _sprinklerRadiusController = TextEditingController(text: widget.schedule?.sprinklerRadius.toString() ?? '');
    _expectedMoistureController = TextEditingController(text: widget.schedule?.expectedMoisture.toString() ?? '');
    _estimatedTimeHoursController = TextEditingController(text: widget.schedule?.estimatedTimeHours.toString() ?? '');
    _setTimeController = TextEditingController(text: widget.schedule?.setTime ?? '');
    _angleController = TextEditingController(text: widget.schedule?.angle.toString() ?? '');
    _isAutomatic = widget.schedule?.isAutomatic ?? false;
  }

  @override
  void dispose() {
    _plotIdController.dispose();
    _waterAmountController.dispose();
    _pressureController.dispose();
    _sprinklerRadiusController.dispose();
    _expectedMoistureController.dispose();
    _estimatedTimeHoursController.dispose();
    _setTimeController.dispose();
    _angleController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newSchedule = ScheduleModel(
        id: widget.schedule?.id ?? '',
        plotId: _plotIdController.text,
        waterAmount: double.parse(_waterAmountController.text),
        pressure: double.parse(_pressureController.text),
        sprinklerRadius: double.parse(_sprinklerRadiusController.text),
        expectedMoisture: double.parse(_expectedMoistureController.text),
        estimatedTimeHours: int.parse(_estimatedTimeHoursController.text),
        setTime: _setTimeController.text,
        angle: int.parse(_angleController.text),
        isAutomatic: _isAutomatic,
      );
      try {
        await serviceLocator<ScheduleFacadeService>().createSchedule(newSchedule);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al guardar el riego programado: $e')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.schedule == null ? "Crear Riego Programado" : "Editar Riego Programado"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Plot ID", _plotIdController),
              _buildTextField("Cantidad de Agua", _waterAmountController, isNumeric: true),
              _buildTextField("Presión", _pressureController, isNumeric: true),
              _buildTextField("Radio del Aspersor", _sprinklerRadiusController, isNumeric: true),
              _buildTextField("Humedad Esperada", _expectedMoistureController, isNumeric: true),
              _buildTextField("Tiempo Estimado (Horas)", _estimatedTimeHoursController, isNumeric: true),
              _buildTextField("Hora Programada", _setTimeController),
              _buildTextField("Ángulo del Aspersor", _angleController, isNumeric: true),
              SwitchListTile(
                title: const Text("Modo Automático"),
                value: _isAutomatic,
                onChanged: (value) {
                  setState(() {
                    _isAutomatic = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingresa $label';
        }
        return null;
      },
    );
  }
}