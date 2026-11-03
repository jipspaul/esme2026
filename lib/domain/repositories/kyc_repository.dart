enum KycResult { approved, rejected }

abstract interface class KycRepository {
  Future<KycResult> verify();
}

class KycException implements Exception {
  final String message;

  const KycException(this.message);
}
