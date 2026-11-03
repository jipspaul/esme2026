import 'package:esme26/data/repositories/customer_profile_repository_impl.dart';
import 'package:esme26/domain/repositories/customer_profile_repository.dart'
    as domain;

abstract class CustomerProfileRepository
    implements domain.CustomerProfileRepository {
  static final CustomerProfileRepository instance =
      CustomerProfileRepositoryImpl();
}
