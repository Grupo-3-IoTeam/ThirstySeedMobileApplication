import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/user_entity.dart';

class UserDataSource {
  // Cargar todos los usuarios desde el archivo JSON en assets
  Future<List<User>> _loadUsers() async {
    final jsonString = await rootBundle.loadString('server/db.json');
    final jsonData = json.decode(jsonString);
    return (jsonData['users'] as List).map((u) => User.fromJson(u)).toList();
  }

  // Buscar un usuario por email y contraseña para el login
  Future<User?> getUserByEmailAndPassword(String email, String password) async {
    final users = await _loadUsers();
    try {
      return users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      return null;
    }
  }

  // Agregar un nuevo usuario (simulación de registro)
  Future<bool> addUser(User newUser) async {
    final users = await _loadUsers();

    // Verificar si el usuario ya existe por email
    if (users.any((u) => u.email == newUser.email)) {
      return false;
    }

    // Simulación de agregar usuario
    users.add(newUser);

    // Nota: esta adición es solo para simular; rootBundle no permite escribir en assets
    return true;
  }
}
