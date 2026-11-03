import 'package:esme26/domain/models/customer_profile.dart';
import 'package:esme26/domain/repositories/repository.dart';

abstract interface class CustomerProfileRepository
    implements Repository<CustomerProfile, String> {}
