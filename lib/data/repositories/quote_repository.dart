import 'package:esme26/data/repositories/quote_repository_impl.dart';
import 'package:esme26/domain/repositories/quote_repository.dart' as domain;

abstract class QuoteRepository implements domain.QuoteRepository {
  static final QuoteRepository instance = QuoteRepositoryImpl();
}
