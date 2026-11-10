import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/favorite_repository.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/domain/models/favorite.dart';

class FavoriteRepositoryImpl extends InMemoryRepository<Favorite, FavoriteId> implements FavoriteRepository {
  static final FavoriteRepositoryImpl _instance = FavoriteRepositoryImpl._internal();
  factory FavoriteRepositoryImpl() => _instance;
  FavoriteRepositoryImpl._internal()
    : super(MockData.favorites, keyOf: (item) => (customerId: requireRepositoryId(item.customerId), artisanId: requireRepositoryId(item.artisanId)));
}
