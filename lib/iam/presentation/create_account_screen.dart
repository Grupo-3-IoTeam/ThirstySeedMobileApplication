import 'package:flutter/material.dart';
import '../application/auth_service.dart';
import '../domain/entities/user_entity.dart';

class CreateAccountScreen extends StatefulWidget {
  final AuthService authService;

  const CreateAccountScreen({Key? key, required this.authService}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  void _signup() async {
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Genera un ID único
      name: _nameController.text,
      lastName: _lastNameController.text,
      city: _cityController.text,
      telephone: _telephoneController.text,
      email: _emailController.text,
      password: _passwordController.text,
      imageUrl: '', // Añade una URL de imagen si es necesario
    );

    final success = await widget.authService.signup(newUser);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuenta creada exitosamente')),
      );
      Navigator.pop(context); // Vuelve a la pantalla de login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El usuario ya existe')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle, size: 120, color: Colors.black),
              const SizedBox(height: 24),
              const Text(
                'Create New Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Divider(color: Colors.black, thickness: 1, indent: 40, endIndent: 40, height: 30),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _buildTextField(_nameController, 'Name')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField(_lastNameController, 'Last Name')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField(_cityController, 'City')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField(_phoneController, 'Telephone')),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(_emailController, 'Email'),
              const SizedBox(height: 16),
              _buildTextField(_passwordController, 'Password', obscureText: true),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Sign up', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.green),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.green)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.green)),
      ),
    );
  }
}
