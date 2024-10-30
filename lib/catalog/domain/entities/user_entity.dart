import 'plot_entity.dart';
import 'water_supplier_entity.dart';

class User {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String location;
  final String profileImage;
  final List<Plot> plots;
  final WaterSupplier waterSupplier;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.location,
    required this.profileImage,
    required this.plots,
    required this.waterSupplier,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      location: json['location'],
      profileImage: json['profileImage'],
      plots: (json['plots'] as List)
          .map((plot) => Plot.fromJson(plot))
          .toList(),
      waterSupplier: WaterSupplier.fromJson(json['waterSupplier']),
    );
  }
}
