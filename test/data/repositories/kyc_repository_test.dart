import 'package:esme26/data/repositories/kyc_repository.dart';
import 'package:esme26/data/repositories/kyc_repository_impl.dart';
import 'package:esme26/domain/repositories/kyc_repository.dart' as domain;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('KYC repository facade and factory share the same singleton', () {
    expect(identical(KycRepositoryImpl(), KycRepositoryImpl()), isTrue);
    expect(identical(KycRepository.instance, KycRepositoryImpl()), isTrue);
    expect(KycRepository.instance, isA<domain.KycRepository>());
  });

  test('Mock KYC repository approves asynchronously', () async {
    expect(await KycRepository.instance.verify(), domain.KycResult.approved);
  });
}
