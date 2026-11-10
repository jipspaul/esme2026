import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/payment_repository.dart';
import 'package:esme26/domain/models/payment.dart';

class PaymentRepositoryImpl extends InMemoryRepository<Payment, String> implements PaymentRepository {
  static final PaymentRepositoryImpl _instance = PaymentRepositoryImpl._internal();
  factory PaymentRepositoryImpl() => _instance;
  PaymentRepositoryImpl._internal() : super(MockData.payments, keyOf: (item) => requireRepositoryId(item.id));
}
