import 'package:esme26/data/repositories/message_repository_impl.dart';
import 'package:esme26/domain/repositories/message_repository.dart' as domain;

abstract class MessageRepository implements domain.MessageRepository {
  static final MessageRepository instance = MessageRepositoryImpl();
}
