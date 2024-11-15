class UserAuth {
  final String email;
  final String password;

  UserAuth({
    required this.email,
    required this.password,
  });

  /// Crear un objeto `UserAuth` desde un JSON
  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
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

  

