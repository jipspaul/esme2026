import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/professional_document_repository.dart';
import 'package:esme26/domain/models/professional_document.dart';

class ProfessionalDocumentRepositoryImpl extends InMemoryRepository<ProfessionalDocument, String> implements ProfessionalDocumentRepository {
  static final ProfessionalDocumentRepositoryImpl _instance = ProfessionalDocumentRepositoryImpl._internal();
  factory ProfessionalDocumentRepositoryImpl() => _instance;
  ProfessionalDocumentRepositoryImpl._internal() : super(MockData.professionalDocuments, keyOf: (item) => requireRepositoryId(item.id));
}
