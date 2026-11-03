import 'package:esme26/data/repositories/kyc_repository_impl.dart';
import 'package:esme26/domain/repositories/kyc_repository.dart' as domain;

abstract class KycRepository implements domain.KycRepository {
  static final KycRepository instance = KycRepositoryImpl();
}
