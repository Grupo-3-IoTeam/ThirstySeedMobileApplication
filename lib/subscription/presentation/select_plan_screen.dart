import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SelectPlanScreen extends StatefulWidget {
  final int userId;

  const SelectPlanScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _SelectPlanScreenState createState() => _SelectPlanScreenState();
}

class _SelectPlanScreenState extends State<SelectPlanScreen> {
  String? selectedPlan;
  bool isLoading = false;

  Future<void> _makePayment() async {
    if (selectedPlan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona un plan.')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final nodeCount = (selectedPlan == 'PREMIUM') ? 5 : 12;
    final validationCode = _generateValidationCode();

    final subscriptionData = {
      'userId': widget.userId,
      'planType': selectedPlan,
      'nodeCount': nodeCount,
      'validationCode': validationCode,
    };

    try {
      final response = await http.post(
        Uri.parse('https://thirstyseedapi-production.up.railway.app/api/v1/subscriptions'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(subscriptionData),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pago realizado con éxito')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al procesar el pago: ${response.body}')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creando suscripción: $e')),
      );
    }
  }

  String _generateValidationCode() {
    const prefix = 'TSeed-';
    final random = List.generate(8, (index) => String.fromCharCode(65 + (index % 26))).join();
    return '$prefix$random';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Plan'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selecciona tu Plan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPlanCard(
                    title: 'PREMIUM',
                    description: 'Monitorización básica con 5 sensores.',
                    price: 7,
                    onSelect: () => setState(() {
                      selectedPlan = 'PREMIUM';
                    }),
                    isSelected: selectedPlan == 'PREMIUM',
                  ),
                  const SizedBox(width: 20),
                  _buildPlanCard(
                    title: 'PLUS',
                    description: 'Automatización avanzada con 12 sensores.',
                    price: 15,
                    onSelect: () => setState(() {
                      selectedPlan = 'PLUS';
                    }),
                    isSelected: selectedPlan == 'PLUS',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _makePayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Pagar', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String description,
    required int price,
    required VoidCallback onSelect,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 12),
            Text(
              '\$$price',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isSelected ? Colors.white : Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}

