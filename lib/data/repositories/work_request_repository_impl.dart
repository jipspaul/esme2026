import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/work_request_repository.dart';
import 'package:esme26/domain/models/work_request.dart';

class WorkRequestRepositoryImpl extends InMemoryRepository<WorkRequest, String> implements WorkRequestRepository {
  static final WorkRequestRepositoryImpl _instance = WorkRequestRepositoryImpl._internal();
  factory WorkRequestRepositoryImpl() => _instance;
  WorkRequestRepositoryImpl._internal() : super(MockData.workRequests, keyOf: (item) => requireRepositoryId(item.id));
}
