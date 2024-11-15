import '../domain/entities/user_entity.dart';
import '../infrastructure/data_sources/user_data_source.dart';

class AuthService {
  final UserDataSource dataSource;

  AuthService({required this.dataSource});

  Future<User?> login(String email, String password) async {
    return await dataSource.getUserByEmailAndPassword(email, password);
  }

  Future<bool> signup(User newUser) async {
    return await dataSource.addUser(newUser);
  }
}
