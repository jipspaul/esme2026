import 'package:esme26/domain/models/attachment.dart';

enum DisputeStatus { opened, underReview, resolved, closed }

class Dispute {
  final String id;
  final String jobId;
  final String openedByUserId;
  final String reason;
  final String description;
  final List<Attachment> evidence;
  final DisputeStatus status;
  final DateTime createdAt;
  final String? resolution;
  final DateTime? resolvedAt;

  Dispute({
    required this.id,
    required this.jobId,
    required this.openedByUserId,
    required this.reason,
    required this.description,
    List<Attachment> evidence = const [],
    this.status = DisputeStatus.opened,
    required this.createdAt,
    this.resolution,
    this.resolvedAt,
  }) : evidence = List.unmodifiable(evidence);
}
