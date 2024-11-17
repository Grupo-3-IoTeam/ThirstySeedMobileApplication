import 'dart:math';
import 'package:thirstyseed/subscription/domain/entities/subscription_entity.dart';
import 'package:thirstyseed/subscription/infrastructure/services/subscription_data_source.dart';


class SubscriptionService {
  final SubscriptionDataSource dataSource;

  SubscriptionService({required this.dataSource});

  Future<bool> createSubscription(int userId, String planType) async {
    // Determinar nodeCount basado en el tipo de plan
    int nodeCount = (planType == 'PREMIUM') ? 5 : 12;

    // Generar el código de validación
    final validationCode = _generateValidationCode();

    // Crear la entidad de suscripción
    final subscription = Subscription(
      userId: userId,
      planType: planType,
      nodeCount: nodeCount,
      validationCode: validationCode,
    );

    // Llamar al método del data source para enviar la suscripción
    return await dataSource.createSubscription(subscription);
  }

  // Generar código de validación
  String _generateValidationCode() {
    const prefix = 'TSeed-';
    final random = Random();
    final code = List.generate(8, (_) => String.fromCharCode(random.nextInt(26) + 65)).join();
    return '$prefix$code';
  }
}

