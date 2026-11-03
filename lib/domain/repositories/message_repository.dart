import 'package:esme26/domain/models/message.dart';
import 'package:esme26/domain/repositories/repository.dart';

abstract interface class MessageRepository
    implements Repository<Message, String> {}
