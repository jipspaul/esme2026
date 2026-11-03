import 'package:esme26/data/repositories/work_request_repository_impl.dart';
import 'package:esme26/domain/repositories/work_request_repository.dart'
    as domain;

abstract class WorkRequestRepository implements domain.WorkRequestRepository {
  static final WorkRequestRepository instance = WorkRequestRepositoryImpl();
}
