import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/job_repository.dart';
import 'package:esme26/domain/models/job.dart';

class JobRepositoryImpl extends InMemoryRepository<Job, String> implements JobRepository {
  static final JobRepositoryImpl _instance = JobRepositoryImpl._internal();
  factory JobRepositoryImpl() => _instance;
  JobRepositoryImpl._internal() : super(MockData.jobs, keyOf: (item) => requireRepositoryId(item.id));
}
