import 'package:esme26/data/repositories/refund_repository_impl.dart';
import 'package:esme26/domain/repositories/refund_repository.dart' as domain;

abstract class RefundRepository implements domain.RefundRepository {
  static final RefundRepository instance = RefundRepositoryImpl();
}
