import 'package:esme26/domain/models/appointment.dart';
import 'package:esme26/domain/repositories/repository.dart';

abstract interface class AppointmentRepository
    implements Repository<Appointment, String> {}
