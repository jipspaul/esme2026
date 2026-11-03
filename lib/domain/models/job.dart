import 'package:esme26/domain/models/adress.dart';
import 'package:esme26/domain/models/money.dart';
import 'package:esme26/domain/models/time_slot.dart';

enum JobStatus { scheduled, inProgress, completed, cancelled, disputed }

class Job {
  final String id;
  final String workRequestId;
  final String acceptedQuoteId;
  final String artisanId;
  final String customerId;
  final Adress adress;
  final Money agreedTotal;
  final TimeSlot scheduledPeriod;
  final JobStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? cancellationReason;

  const Job({
    required this.id,
    required this.workRequestId,
    required this.acceptedQuoteId,
    required this.artisanId,
    required this.customerId,
    required this.adress,
    required this.agreedTotal,
    required this.scheduledPeriod,
    this.status = JobStatus.scheduled,
    required this.createdAt,
    this.completedAt,
    this.cancellationReason,
  });
}
