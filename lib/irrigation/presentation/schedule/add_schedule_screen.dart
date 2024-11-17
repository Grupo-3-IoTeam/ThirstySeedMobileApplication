import 'package:flutter/material.dart';
import 'package:thirstyseed/irrigation/domain/entities/schedule_entity.dart';
import 'package:thirstyseed/irrigation/application/schedule_service.dart';

class AddScheduleScreen extends StatefulWidget {
  final ScheduleService scheduleService;
  final Schedule? schedule;

  const AddScheduleScreen({super.key, required this.scheduleService, this.schedule});

  @override
  _AddScheduleScreenState createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final _waterAmountController = TextEditingController();
  final _pressureController = TextEditingController();
  final _sprinklerRadiusController = TextEditingController();
  final _estimatedTimeHoursController = TextEditingController();
  final _setTimeController = TextEditingController();
  final _angleController = TextEditingController();
  bool _isAutomatic = false;

  @override
  void initState() {
    super.initState();
    if (widget.schedule != null) {
      _populateFields(widget.schedule!);
    }
  }

  void _populateFields(Schedule schedule) {
    _waterAmountController.text = schedule.waterAmount.toString();
    _pressureController.text = schedule.pressure.toString();
    _sprinklerRadiusController.text = schedule.sprinklerRadius.toString();
    _estimatedTimeHoursController.text = schedule.estimatedTimeHours.toString();
    _setTimeController.text = schedule.setTime;
    _angleController.text = schedule.angle.toString();
    _isAutomatic = schedule.isAutomatic;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Schedule'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Automatic Schedule'),
              value: _isAutomatic,
              onChanged: (value) {
                setState(() {
                  _isAutomatic = value;
                });
              },
            ),
            _buildTextField(_waterAmountController, 'Water Amount (L)', enabled: !_isAutomatic),
            _buildTextField(_pressureController, 'Pressure (bar)', enabled: !_isAutomatic),
            _buildTextField(_sprinklerRadiusController, 'Sprinkler Radius (m)', enabled: !_isAutomatic),
            const Text('Expected Moisture: 70%', style: TextStyle(fontSize: 16)),
            _buildTextField(_estimatedTimeHoursController, 'Estimated Time (hours)', enabled: !_isAutomatic),
            _buildTextField(_setTimeController, 'Set Time (e.g. 08:00)', enabled: !_isAutomatic),
            _buildTextField(_angleController, 'Angle (degrees)', enabled: !_isAutomatic),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isAutomatic || _validateFields()
                  ? () async {
                      final newSchedule = Schedule(
                        id: widget.schedule?.id ?? 0,
                        plotId: 1, // Por ahora, siempre será 1
                        waterAmount: int.tryParse(_waterAmountController.text) ?? 0,
                        pressure: int.tryParse(_pressureController.text) ?? 0,
                        sprinklerRadius: int.tryParse(_sprinklerRadiusController.text) ?? 0,
                        expectedMoisture: 70,
                        estimatedTimeHours: int.tryParse(_estimatedTimeHoursController.text) ?? 0,
                        setTime: _setTimeController.text,
                        angle: int.tryParse(_angleController.text) ?? 0,
                        isAutomatic: _isAutomatic,
                      );

                      if (widget.schedule == null) {
                        await widget.scheduleService.createSchedule(newSchedule);
                      } else {
                        await widget.scheduleService.updateSchedule(newSchedule.id, newSchedule);
                      }
                      Navigator.pushNamed(context, '/scheduleList');
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Save Schedule', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool enabled = true}) {
    return TextField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.green)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.green)),
      ),
    );
  }

  bool _validateFields() {
    return _waterAmountController.text.isNotEmpty &&
        _pressureController.text.isNotEmpty &&
        _sprinklerRadiusController.text.isNotEmpty &&
        _estimatedTimeHoursController.text.isNotEmpty &&
        _setTimeController.text.isNotEmpty &&
        _angleController.text.isNotEmpty;
  }
}