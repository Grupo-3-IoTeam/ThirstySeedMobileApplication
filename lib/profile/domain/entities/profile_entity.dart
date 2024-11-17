class ProfileEntity {
  final int id;
  final int userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final String location;

  ProfileEntity({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.location,
  });

  /// Crear un objeto `ProfileEntity` desde un JSON
  factory ProfileEntity.fromJson(Map<String, dynamic> json) {
    return ProfileEntity(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profileImage: json['profileImage'] ?? '',
      location: json['location'] ?? '',
    );
  }

  /// Convertir un objeto `ProfileEntity` a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'location': location,
    };
  }
}
