class User {
  final String id;
  final String name;
  final String lastName;
  final String city;
  final String telephone;
  final String email;
  final String password;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.city,
    required this.telephone,
    required this.email,
    required this.password,
    required this.imageUrl,
  });

  // Convertir JSON a objeto User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      city: json['city'],
      telephone: json['telephone'],
      email: json['email'],
      password: json['password'],
      imageUrl: json['imageUrl'],
    );
  }

  // Convertir objeto User a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'city': city,
      'telephone': telephone,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
    };
  }
}
