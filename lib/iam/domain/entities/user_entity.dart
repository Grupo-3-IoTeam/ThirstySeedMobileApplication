import 'package:thirstyseed/profile/domain/entities/plot_entity.dart';
import 'package:thirstyseed/profile/domain/entities/water_supplier_entity.dart';

class User {
  final String id;
  final String name;
  final String lastName;
  final String city;
  final String telephone;
  final String email;
  final String password;
  final String imageUrl;
  final List<Plot> plots;
  final WaterSupplier waterSupplier;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.city,
    required this.telephone,
    required this.email,
    required this.password,
    required this.imageUrl,
    required this.plots,
    required this.waterSupplier,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      city: json['city'] ?? '',
      telephone: json['telephone'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      plots: (json['plots'] as List? ?? [])
          .map((plot) => Plot.fromJson(plot))
          .toList(),
      waterSupplier: json['waterSupplier'] != null
          ? WaterSupplier.fromJson(json['waterSupplier'])
          : WaterSupplier(name: 'Unknown', logo: ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'city': city,
      'telephone': telephone,
      'email': email,
      'password': password,
      'plots': plots.map((plot) => plot.toJson()).toList(),
      'waterSupplier': waterSupplier.toJson(),
       'imageUrl': imageUrl,
    };
  }
}
  

