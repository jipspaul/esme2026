import 'package:esme26/data/repositories/conversation_repository_impl.dart';
import 'package:esme26/domain/repositories/conversation_repository.dart'
    as domain;

abstract class ConversationRepository implements domain.ConversationRepository {
  static final ConversationRepository instance = ConversationRepositoryImpl();
}
