enum NotificationKind { workRequest, quote, job, appointment, message, payment, review }

class AppNotification {
  final String id;
  final String userId;
  final NotificationKind kind;
  final String relatedEntityId;
  final String title;
  final String body;
  final DateTime createdAt;
  final DateTime? readAt;

  const AppNotification({
    required this.id,
    required this.userId,
    required this.kind,
    required this.relatedEntityId,
    required this.title,
    required this.body,
    required this.createdAt,
    this.readAt,
  });

  bool get isRead => readAt != null;
}
