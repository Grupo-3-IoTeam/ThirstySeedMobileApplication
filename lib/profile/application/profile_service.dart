import '../domain/entities/profile_entity.dart';
import '../infrastructure/data_sources/profile_data_source.dart';

class ProfileService {
  final ProfileDataSource dataSource;

  ProfileService({required this.dataSource});

  Future<bool> createProfile(ProfileEntity profile) async {
    return await dataSource.createProfile(profile);
  }
}
