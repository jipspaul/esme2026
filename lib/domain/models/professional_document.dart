import 'package:esme26/domain/models/artisan_profile.dart';
import 'package:esme26/domain/models/attachment.dart';

enum ProfessionalDocumentKind { registration, qualification, liabilityInsurance, decennialInsurance }

class ProfessionalDocument {
  final String id;
  final String artisanId;
  final ProfessionalDocumentKind kind;
  final String title;
  final String issuer;
  final Attachment attachment;
  final DateTime issuedAt;
  final DateTime? expiresAt;
  final VerificationStatus verificationStatus;

  ProfessionalDocument({
    required this.id,
    required this.artisanId,
    required this.kind,
    required this.title,
    required this.issuer,
    required this.attachment,
    required this.issuedAt,
    this.expiresAt,
    this.verificationStatus = VerificationStatus.pending,
  }) {
    if (expiresAt != null && !expiresAt!.isAfter(issuedAt)) {
      throw ArgumentError('expiresAt must be after issuedAt');
    }
  }
}
