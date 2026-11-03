import 'package:esme26/domain/models/payment.dart';
import 'package:esme26/domain/repositories/repository.dart';

abstract interface class PaymentRepository
    implements Repository<Payment, String> {}
