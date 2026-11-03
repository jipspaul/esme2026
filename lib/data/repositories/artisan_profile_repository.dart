import 'package:esme26/data/repositories/artisan_profile_repository_impl.dart';
import 'package:esme26/domain/repositories/artisan_profile_repository.dart'
    as domain;

abstract class ArtisanProfileRepository
    implements domain.ArtisanProfileRepository {
  static final ArtisanProfileRepository instance =
      ArtisanProfileRepositoryImpl();
}
