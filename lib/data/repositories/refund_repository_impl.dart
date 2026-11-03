import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/refund_repository.dart';
import 'package:esme26/domain/models/payment.dart';

class RefundRepositoryImpl extends InMemoryRepository<Refund, String>
    implements RefundRepository {
  static final RefundRepositoryImpl _instance =
      RefundRepositoryImpl._internal();
  factory RefundRepositoryImpl() => _instance;
  RefundRepositoryImpl._internal()
    : super(MockData.refunds, keyOf: (item) => requireRepositoryId(item.id));
}
