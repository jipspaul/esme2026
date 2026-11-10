import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/artisan_profile_repository.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/domain/models/artisan_profile.dart';

class ArtisanProfileRepositoryImpl extends InMemoryRepository<ArtisanProfile, String> implements ArtisanProfileRepository {
  static final ArtisanProfileRepositoryImpl _instance = ArtisanProfileRepositoryImpl._internal();
  factory ArtisanProfileRepositoryImpl() => _instance;
  ArtisanProfileRepositoryImpl._internal() : super(MockData.artisanProfiles, keyOf: (item) => requireRepositoryId(item.userId));
}
