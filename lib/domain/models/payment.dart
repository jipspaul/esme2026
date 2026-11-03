import 'package:esme26/domain/models/money.dart';

enum PaymentStatus { pending, processing, succeeded, failed, cancelled }

enum PaymentPurpose { deposit, balance, full }

class Payment {
  final String id;
  final String invoiceId;
  final String customerId;
  final String artisanId;
  final Money amount;
  final PaymentPurpose purpose;
  final PaymentStatus status;
  final String? providerReference;
  final DateTime createdAt;
  final DateTime? paidAt;
  final String? failureReason;

  const Payment({
    required this.id,
    required this.invoiceId,
    required this.customerId,
    required this.artisanId,
    required this.amount,
    required this.purpose,
    this.status = PaymentStatus.pending,
    this.providerReference,
    required this.createdAt,
    this.paidAt,
    this.failureReason,
  });
}

enum RefundStatus { pending, succeeded, failed }

class Refund {
  final String id;
  final String paymentId;
  final Money amount;
  final String reason;
  final RefundStatus status;
  final String? providerReference;
  final DateTime createdAt;
  final DateTime? completedAt;

  const Refund({
    required this.id,
    required this.paymentId,
    required this.amount,
    required this.reason,
    this.status = RefundStatus.pending,
    this.providerReference,
    required this.createdAt,
    this.completedAt,
  });
}
