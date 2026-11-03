import 'package:esme26/domain/models/attachment.dart';

class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String text;
  final List<Attachment> attachments;
  final DateTime sentAt;
  final DateTime? readAt;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    this.text = '',
    List<Attachment> attachments = const [],
    required this.sentAt,
    this.readAt,
  }) : attachments = List.unmodifiable(attachments) {
    if (text.trim().isEmpty && attachments.isEmpty) {
      throw ArgumentError('A message needs text or an attachment');
    }
  }
}
