import 'package:esme26/data/repositories/invoice_repository_impl.dart';
import 'package:esme26/domain/repositories/invoice_repository.dart' as domain;

abstract class InvoiceRepository implements domain.InvoiceRepository {
  static final InvoiceRepository instance = InvoiceRepositoryImpl();
}
