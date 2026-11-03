import 'package:esme26/domain/models/invoice.dart';
import 'package:esme26/domain/repositories/repository.dart';

abstract interface class InvoiceRepository
    implements Repository<Invoice, String> {}
