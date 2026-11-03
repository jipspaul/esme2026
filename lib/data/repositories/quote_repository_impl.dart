import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/quote_repository.dart';
import 'package:esme26/domain/models/quote.dart';

class QuoteRepositoryImpl extends InMemoryRepository<Quote, String>
    implements QuoteRepository {
  static final QuoteRepositoryImpl _instance = QuoteRepositoryImpl._internal();
  factory QuoteRepositoryImpl() => _instance;
  QuoteRepositoryImpl._internal()
    : super(MockData.quotes, keyOf: (item) => requireRepositoryId(item.id));
}
