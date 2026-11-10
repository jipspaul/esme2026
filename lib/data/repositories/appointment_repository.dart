import 'package:esme26/data/repositories/appointment_repository_impl.dart';
import 'package:esme26/domain/repositories/appointment_repository.dart' as domain;

abstract class AppointmentRepository implements domain.AppointmentRepository {
  static final AppointmentRepository instance = AppointmentRepositoryImpl();
}
