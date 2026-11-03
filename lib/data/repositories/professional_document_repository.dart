import 'package:esme26/data/repositories/professional_document_repository_impl.dart';
import 'package:esme26/domain/repositories/professional_document_repository.dart'
    as domain;

abstract class ProfessionalDocumentRepository
    implements domain.ProfessionalDocumentRepository {
  static final ProfessionalDocumentRepository instance =
      ProfessionalDocumentRepositoryImpl();
}
