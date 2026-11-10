import 'dart:io';

import 'package:esme26/data/repositories/repositories.dart';
import 'package:esme26/domain/models/models.dart';
import 'package:esme26/domain/repositories/repositories.dart' as domain;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('domain contracts have no data or Flutter dependencies', () {
    final files = Directory('lib/domain/repositories').listSync().whereType<File>().where((file) => file.path.endsWith('.dart'));
    expect(files, isNotEmpty);
    for (final file in files) {
      final source = file.readAsStringSync();
      expect(source, isNot(contains('package:esme26/data/')));
      expect(source, isNot(contains('package:esme26/ui/')));
      expect(source, isNot(contains('package:flutter/')));
    }
  });

  test('data singletons can be injected through domain interfaces', () {
    final domain.UserRepository users = UserRepository.instance;
    final domain.CustomerProfileRepository customers = CustomerProfileRepository.instance;
    final domain.ArtisanProfileRepository artisans = ArtisanProfileRepository.instance;
    final domain.TradeRepository trades = TradeRepository.instance;
    final domain.ProfessionalDocumentRepository documents = ProfessionalDocumentRepository.instance;
    final domain.PortfolioProjectRepository portfolio = PortfolioProjectRepository.instance;
    final domain.AttachmentRepository attachments = AttachmentRepository.instance;
    final domain.WorkRequestRepository requests = WorkRequestRepository.instance;
    final domain.QuoteRepository quotes = QuoteRepository.instance;
    final domain.JobRepository jobs = JobRepository.instance;
    final domain.AppointmentRepository appointments = AppointmentRepository.instance;
    final domain.AvailabilityRepository availabilities = AvailabilityRepository.instance;
    final domain.ConversationRepository conversations = ConversationRepository.instance;
    final domain.MessageRepository messages = MessageRepository.instance;
    final domain.ReviewRepository reviews = ReviewRepository.instance;
    final domain.InvoiceRepository invoices = InvoiceRepository.instance;
    final domain.PaymentRepository payments = PaymentRepository.instance;
    final domain.RefundRepository refunds = RefundRepository.instance;
    final domain.DisputeRepository disputes = DisputeRepository.instance;
    final domain.FavoriteRepository favorites = FavoriteRepository.instance;
    final domain.AppNotificationRepository notifications = AppNotificationRepository.instance;
    for (final count in [
      users.getAll().length,
      customers.getAll().length,
      artisans.getAll().length,
      trades.getAll().length,
      documents.getAll().length,
      portfolio.getAll().length,
      attachments.getAll().length,
      requests.getAll().length,
      quotes.getAll().length,
      jobs.getAll().length,
      appointments.getAll().length,
      availabilities.getAll().length,
      conversations.getAll().length,
      messages.getAll().length,
      reviews.getAll().length,
      invoices.getAll().length,
      payments.getAll().length,
      refunds.getAll().length,
      disputes.getAll().length,
      favorites.getAll().length,
      notifications.getAll().length,
    ]) {
      expect(count, greaterThan(0));
    }
  });

  test('profiles refer to users with the right roles and existing trades', () {
    for (final profile in CustomerProfileRepository.instance.getAll()) {
      final user = UserRepository.instance.getById(profile.userId)!;
      expect(user.roles, contains(UserRole.customer));
    }
    for (final profile in ArtisanProfileRepository.instance.getAll()) {
      final user = UserRepository.instance.getById(profile.userId)!;
      expect(user.roles, contains(UserRole.artisan));
      for (final tradeId in profile.tradeIds) {
        expect(TradeRepository.instance.getById(tradeId), isNotNull);
      }
      expect(profile.serviceAreas, isNotEmpty);
      expect(profile.serviceAreas.first.radiusInKm, greaterThan(0));
      expect(profile.businessAdress.location, isNotNull);
      expect(profile.hourlyRate!.currency, 'EUR');
    }
    for (final trade in TradeRepository.instance.getAll()) {
      if (trade.parentTradeId != null) {
        expect(TradeRepository.instance.getById(trade.parentTradeId!), isNotNull);
      }
    }
  });

  test('attachments, professional documents and portfolio share valid references', () {
    for (final attachment in AttachmentRepository.instance.getAll()) {
      expect(UserRepository.instance.getById(attachment.uploadedByUserId), isNotNull);
      expect(attachment.url.host, endsWith('.example.test'));
    }
    for (final document in ProfessionalDocumentRepository.instance.getAll()) {
      expect(ArtisanProfileRepository.instance.getById(document.artisanId), isNotNull);
      expect(AttachmentRepository.instance.getById(document.attachment.id), same(document.attachment));
      expect(document.expiresAt!.isAfter(document.issuedAt), isTrue);
    }
    for (final project in PortfolioProjectRepository.instance.getAll()) {
      expect(ArtisanProfileRepository.instance.getById(project.artisanId), isNotNull);
      for (final tradeId in project.tradeIds) {
        expect(TradeRepository.instance.getById(tradeId), isNotNull);
      }
      for (final media in project.media) {
        expect(AttachmentRepository.instance.getById(media.id), same(media));
      }
    }
  });

  test('requests, accepted quotes and jobs agree on parties and amounts', () {
    for (final request in WorkRequestRepository.instance.getAll()) {
      expect(CustomerProfileRepository.instance.getById(request.customerId), isNotNull);
      for (final tradeId in request.tradeIds) {
        expect(TradeRepository.instance.getById(tradeId), isNotNull);
      }
      for (final attachment in request.attachments) {
        expect(AttachmentRepository.instance.getById(attachment.id), same(attachment));
      }
      expect(request.budget, isNotNull);
      expect(request.preferredPeriod, isNotNull);
    }
    for (final quote in QuoteRepository.instance.getAll()) {
      final request = WorkRequestRepository.instance.getById(quote.workRequestId)!;
      expect(quote.customerId, request.customerId);
      expect(ArtisanProfileRepository.instance.getById(quote.artisanId), isNotNull);
      expect(quote.status, QuoteStatus.accepted);
      expect(quote.total.minorUnits, greaterThanOrEqualTo(request.budget!.minimum.minorUnits));
      expect(quote.total.minorUnits, lessThanOrEqualTo(request.budget!.maximum.minorUnits));
    }
    for (final job in JobRepository.instance.getAll()) {
      final quote = QuoteRepository.instance.getById(job.acceptedQuoteId)!;
      expect(job.workRequestId, quote.workRequestId);
      expect(job.customerId, quote.customerId);
      expect(job.artisanId, quote.artisanId);
      expect(job.agreedTotal, quote.total);
      expect(job.scheduledPeriod, same(quote.proposedPeriod));
    }
  });

  test('invoices, payments and refunds reconcile with the jobs', () {
    for (final invoice in InvoiceRepository.instance.getAll()) {
      final job = JobRepository.instance.getById(invoice.jobId)!;
      expect(invoice.customerId, job.customerId);
      expect(invoice.artisanId, job.artisanId);
      expect(invoice.total, job.agreedTotal);
      if (invoice.documentId != null) {
        expect(AttachmentRepository.instance.getById(invoice.documentId!), isNotNull);
      }
      final payments = PaymentRepository.instance.getAll().where(
        (payment) => payment.invoiceId == invoice.id && payment.status == PaymentStatus.succeeded,
      );
      expect(payments.fold(0, (sum, payment) => sum + payment.amount.minorUnits), invoice.total.minorUnits);
    }
    for (final payment in PaymentRepository.instance.getAll()) {
      final invoice = InvoiceRepository.instance.getById(payment.invoiceId)!;
      expect(payment.customerId, invoice.customerId);
      expect(payment.artisanId, invoice.artisanId);
      expect(payment.amount.currency, invoice.currency);
      expect(payment.paidAt, invoice.paidAt);
    }
    for (final refund in RefundRepository.instance.getAll()) {
      final payment = PaymentRepository.instance.getById(refund.paymentId)!;
      expect(refund.amount.currency, payment.amount.currency);
      expect(refund.amount.minorUnits, lessThanOrEqualTo(payment.amount.minorUnits));
      expect(refund.createdAt.isBefore(payment.paidAt!), isFalse);
    }
  });

  test('appointments and availability reference the artisan and work request', () {
    for (final appointment in AppointmentRepository.instance.getAll()) {
      final request = WorkRequestRepository.instance.getById(appointment.workRequestId)!;
      expect(appointment.customerId, request.customerId);
      expect(ArtisanProfileRepository.instance.getById(appointment.artisanId), isNotNull);
      final job = JobRepository.instance.getById(appointment.jobId!)!;
      expect(job.workRequestId, request.id);
      expect(job.artisanId, appointment.artisanId);
    }
    for (final availability in AvailabilityRepository.instance.getAll()) {
      expect(ArtisanProfileRepository.instance.getById(availability.artisanId), isNotNull);
    }
  });

  test('conversation messages have valid senders, media and last-message pointer', () {
    for (final conversation in ConversationRepository.instance.getAll()) {
      expect(CustomerProfileRepository.instance.getById(conversation.customerId), isNotNull);
      expect(ArtisanProfileRepository.instance.getById(conversation.artisanId), isNotNull);
      expect(WorkRequestRepository.instance.getById(conversation.workRequestId!), isNotNull);
      final last = MessageRepository.instance.getById(conversation.lastMessageId!)!;
      expect(last.conversationId, conversation.id);
      expect(last.sentAt, conversation.updatedAt);
    }
    for (final message in MessageRepository.instance.getAll()) {
      final conversation = ConversationRepository.instance.getById(message.conversationId)!;
      expect({conversation.customerId, conversation.artisanId}, contains(message.senderId));
      for (final attachment in message.attachments) {
        expect(AttachmentRepository.instance.getById(attachment.id), same(attachment));
      }
    }
  });

  test('reviews refer to completed jobs; disputes refer to disputed jobs', () {
    for (final review in ReviewRepository.instance.getAll()) {
      final job = JobRepository.instance.getById(review.jobId)!;
      expect(job.status, JobStatus.completed);
      expect(review.customerId, job.customerId);
      expect(review.artisanId, job.artisanId);
      expect(review.createdAt.isBefore(job.completedAt!), isFalse);
    }
    for (final dispute in DisputeRepository.instance.getAll()) {
      final job = JobRepository.instance.getById(dispute.jobId)!;
      expect(job.status, JobStatus.disputed);
      expect({job.customerId, job.artisanId}, contains(dispute.openedByUserId));
      for (final attachment in dispute.evidence) {
        expect(AttachmentRepository.instance.getById(attachment.id), same(attachment));
      }
    }
  });

  test('favorites and notification targets exist', () {
    for (final favorite in FavoriteRepository.instance.getAll()) {
      expect(CustomerProfileRepository.instance.getById(favorite.customerId), isNotNull);
      expect(ArtisanProfileRepository.instance.getById(favorite.artisanId), isNotNull);
    }
    for (final notification in AppNotificationRepository.instance.getAll()) {
      expect(UserRepository.instance.getById(notification.userId), isNotNull);
      final id = notification.relatedEntityId;
      final target = switch (notification.kind) {
        NotificationKind.workRequest => WorkRequestRepository.instance.getById(id),
        NotificationKind.quote => QuoteRepository.instance.getById(id),
        NotificationKind.job => JobRepository.instance.getById(id),
        NotificationKind.appointment => AppointmentRepository.instance.getById(id),
        NotificationKind.message => MessageRepository.instance.getById(id),
        NotificationKind.payment => PaymentRepository.instance.getById(id),
        NotificationKind.review => ReviewRepository.instance.getById(id),
      };
      expect(target, isNotNull);
    }
  });
}
