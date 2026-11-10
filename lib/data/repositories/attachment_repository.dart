import 'package:esme26/data/repositories/attachment_repository_impl.dart';
import 'package:esme26/domain/repositories/attachment_repository.dart' as domain;

abstract class AttachmentRepository implements domain.AttachmentRepository {
  static final AttachmentRepository instance = AttachmentRepositoryImpl();
}
