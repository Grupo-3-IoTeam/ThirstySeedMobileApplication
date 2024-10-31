import 'package:thirstyseed/iam/domain/entities/user_entity.dart';
import '../infrastructure/repositories/user_repository.dart';

class FetchUserProfile {
  final UserRepository userRepository;

  FetchUserProfile(this.userRepository);

  Future<User> call() async {
    final data = await userRepository.getUserData();
    // Convierte el JSON a un objeto `User`
    return User.fromJson(data);
  }
}


