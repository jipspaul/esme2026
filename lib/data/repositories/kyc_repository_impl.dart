import 'package:esme26/data/repositories/kyc_repository.dart';
import 'package:esme26/domain/repositories/kyc_repository.dart' show KycResult;

class KycRepositoryImpl implements KycRepository {
  static final KycRepositoryImpl _instance = KycRepositoryImpl._internal();
  factory KycRepositoryImpl() => _instance;
  KycRepositoryImpl._internal();

  @override
  Future<KycResult> verify() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return KycResult.approved;
  }
}
