import 'package:esme26/data/repositories/availability_repository_impl.dart';
import 'package:esme26/domain/repositories/availability_repository.dart' as domain;

abstract class AvailabilityRepository implements domain.AvailabilityRepository {
  static final AvailabilityRepository instance = AvailabilityRepositoryImpl();
}
