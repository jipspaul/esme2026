import 'package:esme26/domain/models/adress.dart';
import 'package:esme26/domain/models/attachment.dart';
import 'package:esme26/domain/models/money.dart';
import 'package:esme26/domain/models/time_slot.dart';

enum WorkRequestStatus { draft, published, assigned, closed, cancelled }

enum WorkUrgency { flexible, scheduled, urgent }

enum PropertyType { apartment, house, other }

class WorkRequest {
  final String id;
  final String customerId;
  final String title;
  final String description;
  final Set<String> tradeIds;
  final Adress adress;
  final PropertyType propertyType;
  final WorkUrgency urgency;
  final WorkRequestStatus status;
  final Budget? budget;
  final TimeSlot? preferredPeriod;
  final List<Attachment> attachments;
  final DateTime createdAt;
  final DateTime updatedAt;

  WorkRequest({
    required this.id,
    required this.customerId,
    required this.title,
    required this.description,
    required Set<String> tradeIds,
    required this.adress,
    required this.propertyType,
    this.urgency = WorkUrgency.flexible,
    this.status = WorkRequestStatus.draft,
    this.budget,
    this.preferredPeriod,
    List<Attachment> attachments = const [],
    required this.createdAt,
    required this.updatedAt,
  }) : tradeIds = Set.unmodifiable(tradeIds),
       attachments = List.unmodifiable(attachments);
}
