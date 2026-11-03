import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/app_notification_repository_impl.dart';
import 'package:esme26/data/repositories/appointment_repository_impl.dart';
import 'package:esme26/data/repositories/artisan_profile_repository_impl.dart';
import 'package:esme26/data/repositories/attachment_repository_impl.dart';
import 'package:esme26/data/repositories/availability_repository_impl.dart';
import 'package:esme26/data/repositories/conversation_repository_impl.dart';
import 'package:esme26/data/repositories/customer_profile_repository_impl.dart';
import 'package:esme26/data/repositories/dispute_repository_impl.dart';
import 'package:esme26/data/repositories/favorite_repository_impl.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/in_memory_user_repository.dart';
import 'package:esme26/data/repositories/invoice_repository_impl.dart';
import 'package:esme26/data/repositories/job_repository_impl.dart';
import 'package:esme26/data/repositories/message_repository_impl.dart';
import 'package:esme26/data/repositories/payment_repository_impl.dart';
import 'package:esme26/data/repositories/portfolio_project_repository_impl.dart';
import 'package:esme26/data/repositories/professional_document_repository_impl.dart';
import 'package:esme26/data/repositories/quote_repository_impl.dart';
import 'package:esme26/data/repositories/refund_repository_impl.dart';
import 'package:esme26/data/repositories/repositories.dart';
import 'package:esme26/data/repositories/review_repository_impl.dart';
import 'package:esme26/data/repositories/trade_repository_impl.dart';
import 'package:esme26/data/repositories/user_repository_JP.dart';
import 'package:esme26/data/repositories/user_repository_impl.dart';
import 'package:esme26/data/repositories/work_request_repository_impl.dart';
import 'package:esme26/domain/models/models.dart';
import 'package:esme26/domain/repositories/repositories.dart' as domain;
import 'package:flutter_test/flutter_test.dart';

void checkRepository<T, K extends Object>({
  required String name,
  required InMemoryRepository<T, K> Function() create,
  required domain.Repository<T, K> Function() instance,
  required List<T> seed,
  required K Function(T) keyOf,
  required K missingId,
}) {
  group(name, () {
    setUp(() => create().reset());
    tearDown(() => create().reset());

    test('factory and interface share the same singleton', () {
      expect(create(), same(create()));
      expect(instance(), same(create()));
      expect(instance(), same(instance()));
    });

    test('all fixtures can be retrieved by their real keys', () {
      final repository = instance();
      expect(seed, isNotEmpty);
      expect(repository.getAll(), orderedEquals(seed));
      for (final entity in seed) {
        expect(repository.getById(keyOf(entity)), same(entity));
      }
      expect(repository.getById(missingId), isNull);
    });

    test('snapshots are immutable and unaffected by later writes', () {
      final repository = instance();
      final snapshot = repository.getAll();
      expect(() => snapshot.clear(), throwsUnsupportedError);
      repository.delete(keyOf(seed.first));
      expect(snapshot, orderedEquals(seed));
      expect(repository.getAll(), hasLength(seed.length - 1));
    });

    test('deletion and upsert are shared between accesses', () {
      final entity = seed.first;
      final id = keyOf(entity);
      instance().delete(id);
      expect(create().getById(id), isNull);
      expect(() => instance().delete(id), throwsStateError);
      create().save(entity);
      expect(instance().getById(id), same(entity));
      expect(instance().getAll(), hasLength(seed.length));
      instance().save(entity);
      expect(create().getAll(), hasLength(seed.length));
    });

    test('reset restores the original fixtures', () {
      instance().delete(keyOf(seed.first));
      create().reset();
      expect(instance().getAll(), orderedEquals(seed));
    });
  });
}

void main() {
  checkRepository(
    name: 'UserRepository',
    create: UserRepositoryJP.new,
    instance: () => UserRepository.instance,
    seed: MockData.users,
    keyOf: (item) => item.id!,
    missingId: 'missing',
  );
  checkRepository(
    name: 'CustomerProfileRepository',
    create: CustomerProfileRepositoryImpl.new,
    instance: () => CustomerProfileRepository.instance,
    seed: MockData.customerProfiles,
    keyOf: (item) => item.userId,
    missingId: 'missing',
  );
  checkRepository(
    name: 'ArtisanProfileRepository',
    create: ArtisanProfileRepositoryImpl.new,
    instance: () => ArtisanProfileRepository.instance,
    seed: MockData.artisanProfiles,
    keyOf: (item) => item.userId,
    missingId: 'missing',
  );
  checkRepository(
    name: 'TradeRepository',
    create: TradeRepositoryImpl.new,
    instance: () => TradeRepository.instance,
    seed: MockData.trades,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'ProfessionalDocumentRepository',
    create: ProfessionalDocumentRepositoryImpl.new,
    instance: () => ProfessionalDocumentRepository.instance,
    seed: MockData.professionalDocuments,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'PortfolioProjectRepository',
    create: PortfolioProjectRepositoryImpl.new,
    instance: () => PortfolioProjectRepository.instance,
    seed: MockData.portfolioProjects,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'AttachmentRepository',
    create: AttachmentRepositoryImpl.new,
    instance: () => AttachmentRepository.instance,
    seed: MockData.attachments,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'WorkRequestRepository',
    create: WorkRequestRepositoryImpl.new,
    instance: () => WorkRequestRepository.instance,
    seed: MockData.workRequests,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'QuoteRepository',
    create: QuoteRepositoryImpl.new,
    instance: () => QuoteRepository.instance,
    seed: MockData.quotes,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'JobRepository',
    create: JobRepositoryImpl.new,
    instance: () => JobRepository.instance,
    seed: MockData.jobs,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'AppointmentRepository',
    create: AppointmentRepositoryImpl.new,
    instance: () => AppointmentRepository.instance,
    seed: MockData.appointments,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'AvailabilityRepository',
    create: AvailabilityRepositoryImpl.new,
    instance: () => AvailabilityRepository.instance,
    seed: MockData.availabilities,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'ConversationRepository',
    create: ConversationRepositoryImpl.new,
    instance: () => ConversationRepository.instance,
    seed: MockData.conversations,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'MessageRepository',
    create: MessageRepositoryImpl.new,
    instance: () => MessageRepository.instance,
    seed: MockData.messages,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'ReviewRepository',
    create: ReviewRepositoryImpl.new,
    instance: () => ReviewRepository.instance,
    seed: MockData.reviews,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'InvoiceRepository',
    create: InvoiceRepositoryImpl.new,
    instance: () => InvoiceRepository.instance,
    seed: MockData.invoices,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'PaymentRepository',
    create: PaymentRepositoryImpl.new,
    instance: () => PaymentRepository.instance,
    seed: MockData.payments,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'RefundRepository',
    create: RefundRepositoryImpl.new,
    instance: () => RefundRepository.instance,
    seed: MockData.refunds,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository(
    name: 'DisputeRepository',
    create: DisputeRepositoryImpl.new,
    instance: () => DisputeRepository.instance,
    seed: MockData.disputes,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );
  checkRepository<Favorite, FavoriteId>(
    name: 'FavoriteRepository',
    create: FavoriteRepositoryImpl.new,
    instance: () => FavoriteRepository.instance,
    seed: MockData.favorites,
    keyOf: (item) => (customerId: item.customerId, artisanId: item.artisanId),
    missingId: (customerId: 'missing', artisanId: 'missing'),
  );
  checkRepository(
    name: 'AppNotificationRepository',
    create: AppNotificationRepositoryImpl.new,
    instance: () => AppNotificationRepository.instance,
    seed: MockData.appNotifications,
    keyOf: (item) => item.id,
    missingId: 'missing',
  );

  group('In-memory storage', () {
    test(
      'upsert replaces content, inserts new ids and preserves snapshots',
      () {
        final repository = InMemoryRepository<Trade, String>([
          const Trade(id: 'trade', name: 'Initial'),
        ], keyOf: (item) => requireRepositoryId(item.id));
        final snapshot = repository.getAll();
        const replacement = Trade(id: 'trade', name: 'Updated');
        repository.save(replacement);
        expect(repository.getById('trade'), same(replacement));
        expect(repository.getAll(), hasLength(1));
        expect(snapshot.single.name, 'Initial');
        repository.save(const Trade(id: 'other', name: 'Other'));
        expect(repository.getAll(), hasLength(2));
        repository.reset();
        expect(repository.getById('other'), isNull);
        expect(repository.getById('trade')!.name, 'Initial');
      },
    );

    test('duplicate seed ids fail explicitly', () {
      expect(
        () => InMemoryRepository<Trade, String>([
          const Trade(id: 'duplicate', name: 'One'),
          const Trade(id: 'duplicate', name: 'Two'),
        ], keyOf: (item) => item.id),
        throwsStateError,
      );
    });

    test('blank ids cannot be persisted', () {
      final repository = TradeRepositoryImpl();
      addTearDown(repository.reset);
      for (final id in ['', ' \n ']) {
        expect(
          () => repository.save(Trade(id: id, name: 'Invalid')),
          throwsArgumentError,
        );
      }
      expect(repository.getAll(), orderedEquals(MockData.trades));
      expect(() => requireRepositoryId(null), throwsArgumentError);
    });

    test('favorite keys cannot collide through string concatenation', () {
      final repository = FavoriteRepositoryImpl();
      addTearDown(repository.reset);
      final first = Favorite(
        customerId: 'a:b',
        artisanId: 'c',
        createdAt: MockData.createdAt,
      );
      final second = Favorite(
        customerId: 'a',
        artisanId: 'b:c',
        createdAt: MockData.createdAt,
      );
      repository.save(first);
      repository.save(second);
      expect(
        repository.getById((customerId: 'a:b', artisanId: 'c')),
        same(first),
      );
      expect(
        repository.getById((customerId: 'a', artisanId: 'b:c')),
        same(second),
      );
      expect(
        () => repository.save(
          Favorite(
            customerId: '',
            artisanId: 'artisan',
            createdAt: MockData.createdAt,
          ),
        ),
        throwsArgumentError,
      );
    });
  });

  for (final (name, create) in <(String, InMemoryUserRepository Function())>[
    ('UserRepositoryJP', UserRepositoryJP.new),
    ('UserRepositoryImpl', UserRepositoryImpl.new),
  ]) {
    group('$name current user', () {
      setUp(() => create().reset());
      tearDown(() => create().reset());

      test('default current user is present in the user catalog', () {
        final repository = create();
        expect(create(), same(repository));
        expect(repository.getUser(), same(MockData.customer));
        expect(
          repository.getById(repository.getUser()!.id!),
          same(repository.getUser()),
        );
      });

      test('onboarding drafts remain usable without a persistent id', () {
        final draft = User(
          firstName: 'Draft',
          lastName: 'Client',
          email: 'draft@example.test',
          birthDateInMillisFromEpoch: 0,
          adress: MockData.adress,
        );
        create().setUser(draft);
        expect(create().getUser(), same(draft));
        expect(create().getAll(), orderedEquals(MockData.users));
        expect(() => create().save(draft), throwsArgumentError);
      });

      test(
        'saving and deleting the current user keep the session consistent',
        () {
          final replacement = User(
            id: 'customer-1',
            firstName: 'Updated',
            lastName: 'Client',
            email: 'updated@example.test',
            birthDateInMillisFromEpoch: 0,
            adress: MockData.adress,
          );
          final repository = create();
          repository.save(replacement);
          expect(repository.getUser(), same(replacement));
          expect(repository.getById('customer-1'), same(replacement));
          repository.delete('customer-1');
          expect(repository.getUser(), isNull);
          expect(repository.getById('customer-1'), isNull);
          repository.reset();
          expect(repository.getUser(), same(MockData.customer));
        },
      );

      test('selecting a persistent user updates the shared catalog', () {
        final persisted = User(
          id: 'customer-new',
          firstName: 'New',
          lastName: 'Client',
          email: 'new@example.test',
          birthDateInMillisFromEpoch: 0,
          adress: MockData.adress,
        );
        create().setUser(persisted);
        expect(create().getUser(), same(persisted));
        expect(create().getById('customer-new'), same(persisted));
        create().delete('artisan-1');
        expect(create().getUser(), same(persisted));
      });

      test('invalid persistent user ids leave the session unchanged', () {
        final invalid = User(
          id: ' ',
          firstName: 'Invalid',
          lastName: 'Client',
          email: 'invalid@example.test',
          birthDateInMillisFromEpoch: 0,
          adress: MockData.adress,
        );
        expect(() => create().setUser(invalid), throwsArgumentError);
        expect(create().getUser(), same(MockData.customer));
      });
    });
  }
}
