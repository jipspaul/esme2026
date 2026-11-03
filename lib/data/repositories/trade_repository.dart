import 'package:esme26/data/repositories/trade_repository_impl.dart';
import 'package:esme26/domain/repositories/trade_repository.dart' as domain;

abstract class TradeRepository implements domain.TradeRepository {
  static final TradeRepository instance = TradeRepositoryImpl();
}
