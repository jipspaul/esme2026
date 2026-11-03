import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/trade_repository.dart';
import 'package:esme26/domain/models/trade.dart';

class TradeRepositoryImpl extends InMemoryRepository<Trade, String>
    implements TradeRepository {
  static final TradeRepositoryImpl _instance = TradeRepositoryImpl._internal();
  factory TradeRepositoryImpl() => _instance;
  TradeRepositoryImpl._internal()
    : super(MockData.trades, keyOf: (item) => requireRepositoryId(item.id));
}
