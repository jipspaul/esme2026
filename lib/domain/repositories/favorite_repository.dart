import 'package:esme26/domain/models/favorite.dart';
import 'package:esme26/domain/repositories/repository.dart';

typedef FavoriteId = ({String customerId, String artisanId});

abstract interface class FavoriteRepository implements Repository<Favorite, FavoriteId> {}
