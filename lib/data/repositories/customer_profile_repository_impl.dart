import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/customer_profile_repository.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/domain/models/customer_profile.dart';

class CustomerProfileRepositoryImpl extends InMemoryRepository<CustomerProfile, String> implements CustomerProfileRepository {
  static final CustomerProfileRepositoryImpl _instance = CustomerProfileRepositoryImpl._internal();
  factory CustomerProfileRepositoryImpl() => _instance;
  CustomerProfileRepositoryImpl._internal() : super(MockData.customerProfiles, keyOf: (item) => requireRepositoryId(item.userId));
}
