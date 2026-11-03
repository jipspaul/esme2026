import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/message_repository.dart';
import 'package:esme26/domain/models/message.dart';

class MessageRepositoryImpl extends InMemoryRepository<Message, String>
    implements MessageRepository {
  static final MessageRepositoryImpl _instance =
      MessageRepositoryImpl._internal();
  factory MessageRepositoryImpl() => _instance;
  MessageRepositoryImpl._internal()
    : super(MockData.messages, keyOf: (item) => requireRepositoryId(item.id));
}
