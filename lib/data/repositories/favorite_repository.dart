import 'package:esme26/data/repositories/favorite_repository_impl.dart';
import 'package:esme26/domain/repositories/favorite_repository.dart' as domain;

export 'package:esme26/domain/repositories/favorite_repository.dart' show FavoriteId;

abstract class FavoriteRepository implements domain.FavoriteRepository {
  static final FavoriteRepository instance = FavoriteRepositoryImpl();
}
