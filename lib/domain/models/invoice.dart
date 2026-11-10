import 'package:esme26/domain/models/quote.dart';
import 'package:esme26/domain/models/money.dart';

enum InvoiceStatus { draft, issued, paid, overdue, voided }

class Invoice {
  final String id;
  final String number;
  final String jobId;
  final String artisanId;
  final String customerId;
  final List<QuoteLine> lines;
  final InvoiceStatus status;
  final DateTime issuedAt;
  final DateTime dueAt;
  final DateTime? paidAt;
  final String? documentId;

  Invoice({
    required this.id,
    required this.number,
    required this.jobId,
    required this.artisanId,
    required this.customerId,
    required List<QuoteLine> lines,
    this.status = InvoiceStatus.draft,
    required this.issuedAt,
    required this.dueAt,
    this.paidAt,
    this.documentId,
  }) : lines = List.unmodifiable(lines) {
    if (lines.isEmpty) {
      throw ArgumentError('An invoice must contain at least one line');
    }
    if (lines.any((line) => line.unitPrice.currency != currency)) {
      throw ArgumentError('All invoice lines must use the same currency');
    }
    if (dueAt.isBefore(issuedAt)) {
      throw ArgumentError('dueAt must not be before issuedAt');
    }
  }

  String get currency => lines.first.unitPrice.currency;
  Money get subtotal => lines.map((line) => line.subtotal).reduce((a, b) => a + b);
  Money get tax => lines.map((line) => line.tax).reduce((a, b) => a + b);
  Money get total => subtotal + tax;
}
