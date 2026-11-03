enum AttachmentKind { image, document, video }

class Attachment {
  final String id;
  final String uploadedByUserId;
  final String fileName;
  final String mimeType;
  final Uri url;
  final AttachmentKind kind;
  final int sizeInBytes;
  final DateTime createdAt;

  Attachment({
    required this.id,
    required this.uploadedByUserId,
    required this.fileName,
    required this.mimeType,
    required this.url,
    required this.kind,
    required this.sizeInBytes,
    required this.createdAt,
  }) {
    if (sizeInBytes < 0) {
      throw ArgumentError.value(
        sizeInBytes,
        'sizeInBytes',
        'Must be non-negative',
      );
    }
  }
}
