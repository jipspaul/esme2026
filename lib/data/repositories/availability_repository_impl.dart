import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/availability_repository.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/domain/models/availability.dart';

class AvailabilityRepositoryImpl extends InMemoryRepository<Availability, String> implements AvailabilityRepository {
  static final AvailabilityRepositoryImpl _instance = AvailabilityRepositoryImpl._internal();
  factory AvailabilityRepositoryImpl() => _instance;
  AvailabilityRepositoryImpl._internal() : super(MockData.availabilities, keyOf: (item) => requireRepositoryId(item.id));
}
