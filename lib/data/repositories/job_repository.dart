import 'package:esme26/data/repositories/job_repository_impl.dart';
import 'package:esme26/domain/repositories/job_repository.dart' as domain;

abstract class JobRepository implements domain.JobRepository {
  static final JobRepository instance = JobRepositoryImpl();
}
