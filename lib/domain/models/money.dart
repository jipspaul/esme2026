class Money {
  /// Amount in the currency's smallest unit (cents for EUR).
  final int minorUnits;
  final String currency;

  Money({required this.minorUnits, this.currency = 'EUR'}) {
    if (minorUnits < 0) {
      throw ArgumentError.value(minorUnits, 'minorUnits', 'Must be non-negative');
    }
    if (!RegExp(r'^[A-Z]{3}$').hasMatch(currency)) {
      throw ArgumentError.value(currency, 'currency', 'Expected a currency code');
    }
  }

  Money operator +(Money other) {
    if (currency != other.currency) {
      throw ArgumentError('Cannot add amounts in different currencies');
    }
    return Money(minorUnits: minorUnits + other.minorUnits, currency: currency);
  }

  @override
  bool operator ==(Object other) => other is Money && minorUnits == other.minorUnits && currency == other.currency;

  @override
  int get hashCode => Object.hash(minorUnits, currency);
}

class Budget {
  final Money minimum;
  final Money maximum;

  Budget({required this.minimum, required this.maximum}) {
    if (minimum.currency != maximum.currency || minimum.minorUnits > maximum.minorUnits) {
      throw ArgumentError('Budget bounds must be ordered in the same currency');
    }
  }
}
