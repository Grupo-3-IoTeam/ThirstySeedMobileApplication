import 'package:thirstyseed/profile/domain/entities/plot_entity.dart';
import 'package:thirstyseed/profile/domain/entities/water_supplier_entity.dart';

class User {
  final String email;
  final String password;

  User({
    required this.email,
    required this.password,
  });

  /// Crear un objeto `UserAuth` desde un JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  /// Convertir un objeto `UserAuth` a JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

  

