import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/attachment_repository.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/domain/models/attachment.dart';

class AttachmentRepositoryImpl extends InMemoryRepository<Attachment, String> implements AttachmentRepository {
  static final AttachmentRepositoryImpl _instance = AttachmentRepositoryImpl._internal();
  factory AttachmentRepositoryImpl() => _instance;
  AttachmentRepositoryImpl._internal() : super(MockData.attachments, keyOf: (item) => requireRepositoryId(item.id));
}
