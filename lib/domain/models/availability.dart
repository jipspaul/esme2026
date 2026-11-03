import 'package:esme26/domain/models/time_slot.dart';

enum AvailabilityStatus { available, unavailable }

class Availability {
  final String id;
  final String artisanId;
  final TimeSlot timeSlot;
  final AvailabilityStatus status;

  const Availability({
    required this.id,
    required this.artisanId,
    required this.timeSlot,
    required this.status,
  });
}
