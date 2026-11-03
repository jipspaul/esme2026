import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/dispute_repository.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/domain/models/dispute.dart';

class DisputeRepositoryImpl extends InMemoryRepository<Dispute, String>
    implements DisputeRepository {
  static final DisputeRepositoryImpl _instance =
      DisputeRepositoryImpl._internal();
  factory DisputeRepositoryImpl() => _instance;
  DisputeRepositoryImpl._internal()
    : super(MockData.disputes, keyOf: (item) => requireRepositoryId(item.id));
}
