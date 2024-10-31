import '../data_sources/user_data_source.dart';

class UserRepository {
  final UserDataSource userDataSource;

  UserRepository(this.userDataSource);

  Future<Map<String, dynamic>> getUserData() async {
    // Llama al método fetchUserData en UserDataSource
    return await userDataSource.fetchUserData();
  }
}