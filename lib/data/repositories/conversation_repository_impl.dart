import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/conversation_repository.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/domain/models/conversation.dart';

class ConversationRepositoryImpl extends InMemoryRepository<Conversation, String> implements ConversationRepository {
  static final ConversationRepositoryImpl _instance = ConversationRepositoryImpl._internal();
  factory ConversationRepositoryImpl() => _instance;
  ConversationRepositoryImpl._internal() : super(MockData.conversations, keyOf: (item) => requireRepositoryId(item.id));
}
