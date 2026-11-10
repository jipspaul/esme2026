import 'package:esme26/domain/models/money.dart';
import 'package:esme26/domain/models/time_slot.dart';

enum QuoteStatus { draft, sent, accepted, rejected, expired, withdrawn }

enum QuoteUnit { item, hour, day, squareMeter, meter, fixedPrice }

class QuoteLine {
  final String description;
  final double quantity;
  final QuoteUnit unit;
  final Money unitPrice;

  /// 2000 basis points = 20% VAT.
  final int vatRateBasisPoints;

  QuoteLine({required this.description, required this.quantity, required this.unit, required this.unitPrice, required this.vatRateBasisPoints}) {
    if (!quantity.isFinite || quantity <= 0) {
      throw ArgumentError.value(quantity, 'quantity', 'Must be positive');
    }
    if (vatRateBasisPoints < 0 || vatRateBasisPoints > 10000) {
      throw ArgumentError.value(vatRateBasisPoints, 'vatRateBasisPoints', 'Expected 0 to 10000');
    }
  }

  Money get subtotal => Money(minorUnits: (unitPrice.minorUnits * quantity).round(), currency: unitPrice.currency);

  /// Tax is rounded per line, to the nearest minor unit, half up.
  Money get tax => Money(minorUnits: (subtotal.minorUnits * vatRateBasisPoints + 5000) ~/ 10000, currency: unitPrice.currency);

  Money get total => subtotal + tax;
}

class Quote {
  final String id;
  final String reference;
  final String workRequestId;
  final String artisanId;
  final String customerId;
  final List<QuoteLine> lines;
  final QuoteStatus status;
  final DateTime createdAt;
  final DateTime validUntil;
  final TimeSlot? proposedPeriod;
  final String? terms;

  Quote({
    required this.id,
    required this.reference,
    required this.workRequestId,
    required this.artisanId,
    required this.customerId,
    required List<QuoteLine> lines,
    this.status = QuoteStatus.draft,
    required this.createdAt,
    required this.validUntil,
    this.proposedPeriod,
    this.terms,
  }) : lines = List.unmodifiable(lines) {
    if (lines.isEmpty) {
      throw ArgumentError('A quote must contain at least one line');
    }
    if (lines.any((line) => line.unitPrice.currency != currency)) {
      throw ArgumentError('All quote lines must use the same currency');
    }
    if (!validUntil.isAfter(createdAt)) {
      throw ArgumentError('validUntil must be after createdAt');
    }
  }

  String get currency => lines.first.unitPrice.currency;
  Money get subtotal => lines.map((line) => line.subtotal).reduce((a, b) => a + b);
  Money get tax => lines.map((line) => line.tax).reduce((a, b) => a + b);
  Money get total => subtotal + tax;
}
