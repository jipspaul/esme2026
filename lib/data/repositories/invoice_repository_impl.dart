import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/invoice_repository.dart';
import 'package:esme26/domain/models/invoice.dart';

class InvoiceRepositoryImpl extends InMemoryRepository<Invoice, String>
    implements InvoiceRepository {
  static final InvoiceRepositoryImpl _instance =
      InvoiceRepositoryImpl._internal();
  factory InvoiceRepositoryImpl() => _instance;
  InvoiceRepositoryImpl._internal()
    : super(MockData.invoices, keyOf: (item) => requireRepositoryId(item.id));
}
