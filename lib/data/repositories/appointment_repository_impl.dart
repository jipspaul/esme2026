import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/appointment_repository.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/domain/models/appointment.dart';

class AppointmentRepositoryImpl extends InMemoryRepository<Appointment, String> implements AppointmentRepository {
  static final AppointmentRepositoryImpl _instance = AppointmentRepositoryImpl._internal();
  factory AppointmentRepositoryImpl() => _instance;
  AppointmentRepositoryImpl._internal() : super(MockData.appointments, keyOf: (item) => requireRepositoryId(item.id));
}
