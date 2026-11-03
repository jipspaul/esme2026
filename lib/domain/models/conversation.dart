class Conversation {
  final String id;
  final String customerId;
  final String artisanId;
  final String? workRequestId;
  final String? lastMessageId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Conversation({
    required this.id,
    required this.customerId,
    required this.artisanId,
    this.workRequestId,
    this.lastMessageId,
    required this.createdAt,
    required this.updatedAt,
  });
}
