import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/subscription_entity.dart';

class SubscriptionDataSource {
  final String baseUrl = 'https://thirstyseedapi-production.up.railway.app/api/v1/subscriptions';

  // Crear una suscripción
  Future<bool> createSubscription(Subscription subscription) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(subscription.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      print('Error al crear la suscripción: ${response.body}');
      return false;
    }
  }

  // Obtener una suscripción por userId
  Future<Subscription?> getSubscription(int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Subscription.fromJson(data);
    } else {
      print('Error al obtener la suscripción: ${response.body}');
      return null;
    }
  }
}
