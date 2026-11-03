import 'package:esme26/data/models/adress.dart' as legacy_adress;
import 'package:esme26/data/models/user.dart' as legacy_user;
import 'package:esme26/domain/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

final now = DateTime.utc(2026, 1, 1);
const adress = Adress(
  street: '1 rue du Test',
  city: 'Paris',
  postalCode: '75001',
  country: 'France',
);

QuoteLine line({String currency = 'EUR', double quantity = 1.5}) => QuoteLine(
  description: 'Peinture',
  quantity: quantity,
  unit: QuoteUnit.squareMeter,
  unitPrice: Money(minorUnits: 1999, currency: currency),
  vatRateBasisPoints: 2000,
);

Quote quote({required List<QuoteLine> lines, DateTime? validUntil}) => Quote(
  id: 'quote',
  reference: 'DEV-001',
  workRequestId: 'request',
  artisanId: 'artisan',
  customerId: 'customer',
  lines: lines,
  createdAt: now,
  validUntil: validUntil ?? now.add(const Duration(days: 30)),
);

Invoice invoice({required List<QuoteLine> lines, DateTime? dueAt}) => Invoice(
  id: 'invoice',
  number: 'FAC-001',
  jobId: 'job',
  artisanId: 'artisan',
  customerId: 'customer',
  lines: lines,
  issuedAt: now,
  dueAt: dueAt ?? now.add(const Duration(days: 30)),
);

Attachment attachment() => Attachment(
  id: 'attachment',
  uploadedByUserId: 'customer',
  fileName: 'photo.jpg',
  mimeType: 'image/jpeg',
  url: Uri.parse('https://example.test/photo.jpg'),
  kind: AttachmentKind.image,
  sizeInBytes: 123,
  createdAt: now,
);

void main() {
  group('Compatibility and immutability', () {
    test(
      'existing constructors and imports still reference domain classes',
      () {
        final oldAdress = legacy_adress.Adress(
          street: adress.street,
          city: adress.city,
          postalCode: adress.postalCode,
          country: adress.country,
        );
        final user = legacy_user.User(
          firstName: 'Test',
          lastName: 'Client',
          email: 'client@example.test',
          birthDateInMillisFromEpoch: 123,
          adress: oldAdress,
        );
        expect(user, isA<User>());
        expect(oldAdress, isA<Adress>());
        expect(user.id, isNull);
        expect(user.roles, {UserRole.customer});
        expect(user.birthDateInMillisFromEpoch, 123);
        expect(user.adress, same(oldAdress));
      },
    );

    test('roles are copied, immutable, and can represent both profiles', () {
      final roles = {UserRole.customer, UserRole.artisan};
      final user = User(
        id: 'user',
        firstName: 'Test',
        lastName: 'Artisan',
        email: 'artisan@example.test',
        birthDateInMillisFromEpoch: 123,
        adress: adress,
        roles: roles,
      );
      roles.clear();
      expect(user.roles, hasLength(2));
      expect(() => user.roles.clear(), throwsUnsupportedError);
      expect(
        () => User(
          firstName: 'Test',
          lastName: 'Client',
          email: 'client@example.test',
          birthDateInMillisFromEpoch: 123,
          adress: adress,
          roles: {},
        ),
        throwsArgumentError,
      );
    });

    test(
      'request, portfolio, artisan, messages and disputes copy collections',
      () {
        final trades = {'painting'};
        final media = [attachment()];
        final areas = [
          ServiceArea(
            center: GeoPoint(latitude: 48.8, longitude: 2.3),
            radiusInKm: 20,
          ),
        ];
        final request = WorkRequest(
          id: 'request',
          customerId: 'customer',
          title: 'Peinture',
          description: 'Repeindre le salon',
          tradeIds: trades,
          adress: adress,
          propertyType: PropertyType.apartment,
          attachments: media,
          createdAt: now,
          updatedAt: now,
        );
        final portfolio = PortfolioProject(
          id: 'portfolio',
          artisanId: 'artisan',
          title: 'Salon',
          description: 'Peinture',
          tradeIds: trades,
          media: media,
        );
        final artisan = ArtisanProfile(
          userId: 'artisan',
          companyName: 'Peinture Test',
          registrationNumber: '12345678900012',
          registrationCountryCode: 'FR',
          description: 'Peinture interieure',
          businessAdress: adress,
          tradeIds: trades,
          serviceAreas: areas,
          yearsOfExperience: 5,
        );
        final message = Message(
          id: 'message',
          conversationId: 'conversation',
          senderId: 'customer',
          attachments: media,
          sentAt: now,
        );
        final dispute = Dispute(
          id: 'dispute',
          jobId: 'job',
          openedByUserId: 'customer',
          reason: 'Finish',
          description: 'Incomplete work',
          evidence: media,
          createdAt: now,
        );
        trades.clear();
        media.clear();
        areas.clear();
        for (final ids in [
          request.tradeIds,
          portfolio.tradeIds,
          artisan.tradeIds,
        ]) {
          expect(ids, {'painting'});
          expect(() => ids.clear(), throwsUnsupportedError);
        }
        for (final files in [
          request.attachments,
          portfolio.media,
          message.attachments,
          dispute.evidence,
        ]) {
          expect(files, hasLength(1));
          expect(() => files.clear(), throwsUnsupportedError);
        }
        expect(artisan.serviceAreas, hasLength(1));
        expect(() => artisan.serviceAreas.clear(), throwsUnsupportedError);
      },
    );
  });

  group('Money and pricing', () {
    test('integer money supports equality and same-currency addition', () {
      final amount = Money(minorUnits: 1250);
      expect(amount + Money(minorUnits: 750), Money(minorUnits: 2000));
      expect(amount, Money(minorUnits: 1250));
      expect(amount.hashCode, Money(minorUnits: 1250).hashCode);
      expect(Money(minorUnits: 0).minorUnits, 0);
      expect(() => Money(minorUnits: -1), throwsArgumentError);
      expect(
        () => Money(minorUnits: 100, currency: 'eur'),
        throwsArgumentError,
      );
      expect(
        () => amount + Money(minorUnits: 100, currency: 'USD'),
        throwsArgumentError,
      );
    });

    test('budget validates ordering and currency', () {
      expect(
        Budget(
          minimum: Money(minorUnits: 100),
          maximum: Money(minorUnits: 100),
        ).maximum,
        Money(minorUnits: 100),
      );
      expect(
        () => Budget(
          minimum: Money(minorUnits: 200),
          maximum: Money(minorUnits: 100),
        ),
        throwsArgumentError,
      );
      expect(
        () => Budget(
          minimum: Money(minorUnits: 0),
          maximum: Money(minorUnits: 100, currency: 'USD'),
        ),
        throwsArgumentError,
      );
    });

    test('fractional quantity and VAT round per line', () {
      final item = line();
      expect(item.subtotal.minorUnits, 2999);
      expect(item.tax.minorUnits, 600);
      expect(item.total.minorUnits, 3599);
      final halfCentTax = QuoteLine(
        description: 'Test',
        quantity: 1,
        unit: QuoteUnit.item,
        unitPrice: Money(minorUnits: 5),
        vatRateBasisPoints: 1000,
      );
      expect(halfCentTax.tax.minorUnits, 1);
      expect(
        QuoteLine(
          description: 'Exempt',
          quantity: 1,
          unit: QuoteUnit.item,
          unitPrice: Money(minorUnits: 100),
          vatRateBasisPoints: 0,
        ).tax.minorUnits,
        0,
      );
    });

    test('quote and invoice reuse totals and snapshot the lines', () {
      final items = [line(), line()];
      final estimate = quote(lines: items);
      final bill = invoice(lines: items);
      items.clear();
      expect(estimate.lines, hasLength(2));
      expect(bill.lines, hasLength(2));
      expect(estimate.subtotal.minorUnits, 5998);
      expect(estimate.tax.minorUnits, 1200);
      expect(estimate.total.minorUnits, 7198);
      expect(bill.subtotal, estimate.subtotal);
      expect(bill.tax, estimate.tax);
      expect(bill.total, estimate.total);
      expect(() => estimate.lines.clear(), throwsUnsupportedError);
      expect(() => bill.lines.clear(), throwsUnsupportedError);
    });

    test('empty, mixed-currency and invalid-date documents are rejected', () {
      for (final items in <List<QuoteLine>>[
        [],
        [line(), line(currency: 'USD')],
      ]) {
        expect(() => quote(lines: items), throwsArgumentError);
        expect(() => invoice(lines: items), throwsArgumentError);
      }
      expect(
        () => quote(lines: [line()], validUntil: now),
        throwsArgumentError,
      );
      expect(
        () => invoice(
          lines: [line()],
          dueAt: now.subtract(const Duration(seconds: 1)),
        ),
        throwsArgumentError,
      );
      expect(invoice(lines: [line()], dueAt: now).dueAt, now);
    });

    test('quantity must be finite and positive', () {
      for (final quantity in [0.0, -1.0, double.nan, double.infinity]) {
        expect(() => line(quantity: quantity), throwsArgumentError);
      }
    });

    test('VAT must be in the inclusive 0 to 10000 range', () {
      for (final rate in [-1, 10001]) {
        expect(
          () => QuoteLine(
            description: 'Test',
            quantity: 1,
            unit: QuoteUnit.item,
            unitPrice: Money(minorUnits: 100),
            vatRateBasisPoints: rate,
          ),
          throwsArgumentError,
        );
      }
    });
  });

  group('Local constraints', () {
    test(
      'artisan requires trades, service areas and nonnegative experience',
      () {
        final area = ServiceArea(
          center: GeoPoint(latitude: 0, longitude: 0),
          radiusInKm: 1,
        );
        ArtisanProfile create({
          Set<String> trades = const {'painting'},
          List<ServiceArea>? areas,
          int experience = 0,
        }) => ArtisanProfile(
          userId: 'artisan',
          companyName: 'Test',
          registrationNumber: '12345678900012',
          registrationCountryCode: 'FR',
          description: 'Peinture',
          businessAdress: adress,
          tradeIds: trades,
          serviceAreas: areas ?? [area],
          yearsOfExperience: experience,
        );
        expect(create().yearsOfExperience, 0);
        expect(() => create(trades: {}), throwsArgumentError);
        expect(() => create(areas: []), throwsArgumentError);
        expect(() => create(experience: -1), throwsArgumentError);
      },
    );

    test('attachment size cannot be negative', () {
      expect(
        () => Attachment(
          id: 'attachment',
          uploadedByUserId: 'customer',
          fileName: 'photo.jpg',
          mimeType: 'image/jpeg',
          url: Uri.parse('https://example.test/photo.jpg'),
          kind: AttachmentKind.image,
          sizeInBytes: -1,
          createdAt: now,
        ),
        throwsArgumentError,
      );
    });

    test(
      'coordinates include boundaries but reject non-finite/outside values',
      () {
        expect(GeoPoint(latitude: -90, longitude: 180).latitude, -90);
        expect(GeoPoint(latitude: 90, longitude: -180).longitude, -180);
        for (final latitude in [-90.1, 90.1, double.nan, double.infinity]) {
          expect(
            () => GeoPoint(latitude: latitude, longitude: 0),
            throwsArgumentError,
          );
        }
        for (final longitude in [-180.1, 180.1, double.nan, double.infinity]) {
          expect(
            () => GeoPoint(latitude: 0, longitude: longitude),
            throwsArgumentError,
          );
        }
      },
    );

    test('service radius must be positive and finite', () {
      for (final radius in [0.0, -1.0, double.nan, double.infinity]) {
        expect(
          () => ServiceArea(
            center: GeoPoint(latitude: 0, longitude: 0),
            radiusInKm: radius,
          ),
          throwsArgumentError,
        );
      }
    });

    test('time slots reject empty and inverted periods', () {
      for (final end in [now, now.subtract(const Duration(seconds: 1))]) {
        expect(() => TimeSlot(startsAt: now, endsAt: end), throwsArgumentError);
      }
      expect(
        TimeSlot(
          startsAt: now,
          endsAt: now.add(const Duration(seconds: 1)),
        ).startsAt,
        now,
      );
    });

    test('messages require nonblank text or an attachment', () {
      expect(
        () => Message(
          id: 'message',
          conversationId: 'conversation',
          senderId: 'customer',
          text: ' \n ',
          sentAt: now,
        ),
        throwsArgumentError,
      );
      expect(
        Message(
          id: 'message',
          conversationId: 'conversation',
          senderId: 'customer',
          text: 'Bonjour',
          sentAt: now,
        ).text,
        'Bonjour',
      );
    });

    test('review ratings are integers from 1 through 5', () {
      for (final rating in [0, 1, 5, 6]) {
        Review create() => Review(
          id: 'review',
          jobId: 'job',
          customerId: 'customer',
          artisanId: 'artisan',
          rating: rating,
          comment: 'Test',
          createdAt: now,
        );
        if (rating == 0 || rating == 6) {
          expect(create, throwsArgumentError);
        } else {
          expect(create().rating, rating);
        }
      }
    });

    test('professional document expiry must follow issue date', () {
      expect(
        () => ProfessionalDocument(
          id: 'document',
          artisanId: 'artisan',
          kind: ProfessionalDocumentKind.decennialInsurance,
          title: 'Assurance',
          issuer: 'Insurer',
          attachment: attachment(),
          issuedAt: now,
          expiresAt: now,
        ),
        throwsArgumentError,
      );
    });
  });

  test('request to payment workflow uses explicit relationships', () {
    final estimate = quote(lines: [line()]);
    final period = TimeSlot(
      startsAt: now,
      endsAt: now.add(const Duration(hours: 2)),
    );
    final job = Job(
      id: 'job',
      workRequestId: estimate.workRequestId,
      acceptedQuoteId: estimate.id,
      artisanId: estimate.artisanId,
      customerId: estimate.customerId,
      adress: adress,
      agreedTotal: estimate.total,
      scheduledPeriod: period,
      createdAt: now,
    );
    final bill = invoice(lines: estimate.lines);
    final payment = Payment(
      id: 'payment',
      invoiceId: bill.id,
      customerId: job.customerId,
      artisanId: job.artisanId,
      amount: bill.total,
      purpose: PaymentPurpose.full,
      createdAt: now,
    );
    final refund = Refund(
      id: 'refund',
      paymentId: payment.id,
      amount: Money(minorUnits: 100),
      reason: 'Adjustment',
      createdAt: now,
    );
    expect(job.acceptedQuoteId, estimate.id);
    expect(bill.jobId, job.id);
    expect(payment.invoiceId, bill.id);
    expect(payment.amount, job.agreedTotal);
    expect(payment.status, PaymentStatus.pending);
    expect(refund.paymentId, payment.id);
    expect(refund.status, RefundStatus.pending);

    final appointment = Appointment(
      id: 'appointment',
      workRequestId: job.workRequestId,
      artisanId: job.artisanId,
      customerId: job.customerId,
      jobId: job.id,
      adress: adress,
      timeSlot: period,
    );
    final availability = Availability(
      id: 'availability',
      artisanId: job.artisanId,
      timeSlot: period,
      status: AvailabilityStatus.unavailable,
    );
    final conversation = Conversation(
      id: 'conversation',
      customerId: job.customerId,
      artisanId: job.artisanId,
      workRequestId: job.workRequestId,
      createdAt: now,
      updatedAt: now,
    );
    final favorite = Favorite(
      customerId: job.customerId,
      artisanId: job.artisanId,
      createdAt: now,
    );
    final notification = AppNotification(
      id: 'notification',
      userId: job.customerId,
      kind: NotificationKind.payment,
      relatedEntityId: payment.id,
      title: 'Paiement',
      body: 'Paiement en attente',
      createdAt: now,
    );
    expect(appointment.jobId, job.id);
    expect(availability.artisanId, job.artisanId);
    expect(conversation.workRequestId, job.workRequestId);
    expect(favorite.artisanId, job.artisanId);
    expect(notification.relatedEntityId, payment.id);
    expect(notification.isRead, isFalse);
    expect(CustomerProfile(userId: job.customerId).userId, job.customerId);
    expect(const Trade(id: 'painting', name: 'Peinture').name, 'Peinture');
  });
}
