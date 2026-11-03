import 'package:esme26/domain/models/conversation.dart';
import 'package:esme26/domain/repositories/repository.dart';

abstract interface class ConversationRepository
    implements Repository<Conversation, String> {}
