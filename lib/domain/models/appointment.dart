import 'package:esme26/domain/models/adress.dart';
import 'package:esme26/domain/models/time_slot.dart';

enum AppointmentStatus { proposed, confirmed, completed, cancelled }

class Appointment {
  final String id;
  final String workRequestId;
  final String artisanId;
  final String customerId;
  final String? jobId;
  final Adress adress;
  final TimeSlot timeSlot;
  final AppointmentStatus status;
  final String? notes;

  const Appointment({
    required this.id,
    required this.workRequestId,
    required this.artisanId,
    required this.customerId,
    this.jobId,
    required this.adress,
    required this.timeSlot,
    this.status = AppointmentStatus.proposed,
    this.notes,
  });
}
