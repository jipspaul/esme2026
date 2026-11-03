import 'package:esme26/data/repositories/dispute_repository_impl.dart';
import 'package:esme26/domain/repositories/dispute_repository.dart' as domain;

abstract class DisputeRepository implements domain.DisputeRepository {
  static final DisputeRepository instance = DisputeRepositoryImpl();
}
