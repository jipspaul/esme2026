class Review {
  final String id;
  final String jobId;
  final String customerId;
  final String artisanId;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final String? artisanReply;
  final DateTime? repliedAt;

  Review({
    required this.id,
    required this.jobId,
    required this.customerId,
    required this.artisanId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.artisanReply,
    this.repliedAt,
  }) {
    if (rating < 1 || rating > 5) {
      throw ArgumentError.value(rating, 'rating', 'Expected 1 to 5');
    }
  }
}
