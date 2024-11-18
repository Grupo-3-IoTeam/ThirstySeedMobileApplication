import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterNodeScreen extends StatefulWidget {
  final int plotId;

  const RegisterNodeScreen({Key? key, required this.plotId}) : super(key: key);

  @override
  _RegisterNodeScreenState createState() => _RegisterNodeScreenState();
}

class _RegisterNodeScreenState extends State<RegisterNodeScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _moistureController = TextEditingController();
  final TextEditingController _indicatorController = TextEditingController();
  final TextEditingController _statusController = TextEditingController(text: 'true');
  final TextEditingController _productcodeController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _registerNode() async {
    if (_locationController.text.isEmpty || _moistureController.text.isEmpty ||
        _indicatorController.text.isEmpty || _statusController.text.isEmpty || _productcodeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://thirstyseedapi-production.up.railway.app/api/v1/node'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'plotId': widget.plotId,  // plotId está correcto
          'nodelocation': _locationController.text.trim(),  // Usa 'nodelocation' en lugar de 'location'
          'moisture': int.tryParse(_moistureController.text.trim()) ?? 0,  // Humedad, asegurándote que es un número
          'indicator': _indicatorController.text.trim(),  // Indicador
          'isActive': _statusController.text.trim().toLowerCase() == 'true',  // 'isActive' debe ser un booleano
          'productcode': _productcodeController.text.trim(),  // Código del producto
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context); // Opcional: regresar automáticamente al completar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nodo registrado con éxito')),
        );
      } else {
        throw Exception('Failed to register node: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[100],
        title: const Text(
          'Registrar Nodo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Inputs and labels
            _buildTextField(_locationController, 'Nombre de la locacion', 'Nombre De la locacion'),
            _buildTextField(_moistureController, 'humedad', 'humedad',numeric: true),
            _buildTextField(_indicatorController, 'indiacion', 'indicador'),
            _buildTextField(_statusController, 'estado', 'estado', numeric: true),
            _buildTextField(_productcodeController, 'codigo de producto', 'codigo de producto'),
            const SizedBox(height: 30),
            if (_isSubmitting)
              const Center(child: CircularProgressIndicator())
            else
              _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      String placeholder,
      {bool numeric = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: numeric ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: placeholder,
            filled: true,
            fillColor: Colors.green[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _registerNode,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Registrar Nodo', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
