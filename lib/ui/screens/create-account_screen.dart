import 'package:flutter/material.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono de usuario
              const Icon(
                Icons.account_circle,
                size: 120,
                color: Colors.black,
              ),
              const SizedBox(height: 24),

              // Título
              const Text(
                'Create New Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
                indent: 40,
                endIndent: 40,
                height: 30,
              ),
              const SizedBox(height: 24),

              // Campos de texto (Name, Last Name)
              Row(
                children: [
                  Expanded(
                    child: _buildTextField('Name'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField('Last Name'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Campos de texto (City, Telephone)
              Row(
                children: [
                  Expanded(
                    child: _buildTextField('City'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField('Telephone'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Campo de texto (Email)
              _buildTextField('Email'),
              const SizedBox(height: 16),

              // Campo de texto (Password)
              _buildTextField('Password', obscureText: true),
              const SizedBox(height: 24),

              // Botón de Sign Up
              ElevatedButton(
                onPressed: () {
                  // Acción para crear cuenta
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método auxiliar para crear campos de texto con estilo
  Widget _buildTextField(String label, {bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
