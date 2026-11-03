import 'package:esme26/data/repositories/payment_repository_impl.dart';
import 'package:esme26/domain/repositories/payment_repository.dart' as domain;

abstract class PaymentRepository implements domain.PaymentRepository {
  static final PaymentRepository instance = PaymentRepositoryImpl();
}
