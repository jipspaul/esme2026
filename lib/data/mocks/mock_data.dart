import 'package:esme26/domain/models/models.dart';

/// Deterministic fictional fixtures shared by every in-memory repository.
class MockData {
  MockData._();

  static final createdAt = DateTime.utc(2026, 10, 1, 8);
  static final location = GeoPoint(latitude: 48.8566, longitude: 2.3522);
  static final adress = Adress(street: '1 rue de la Demonstration', city: 'Paris', postalCode: '75001', country: 'France', location: location);
  static final customer = User(
    id: 'customer-1',
    firstName: 'JP',
    lastName: 'J',
    email: 'customer@example.test',
    birthDateInMillisFromEpoch: DateTime.utc(2000, 1, 1).millisecondsSinceEpoch,
    adress: adress,
    createdAt: createdAt,
  );
  static final artisan = User(
    id: 'artisan-1',
    firstName: 'Camille',
    lastName: 'Artisan',
    email: 'artisan@example.test',
    birthDateInMillisFromEpoch: DateTime.utc(1990, 1, 1).millisecondsSinceEpoch,
    adress: adress,
    roles: {UserRole.artisan},
    createdAt: createdAt,
  );
  static final List<User> users = List.unmodifiable([customer, artisan]);

  static final List<CustomerProfile> customerProfiles = List.unmodifiable([
    const CustomerProfile(userId: 'customer-1', presentation: 'Particulier souhaitant renover son logement.'),
  ]);
  static final List<Trade> trades = List.unmodifiable([
    const Trade(id: 'trade-painting', name: 'Peinture'),
    const Trade(id: 'trade-interior-painting', name: 'Peinture interieure', parentTradeId: 'trade-painting'),
  ]);
  static final List<ArtisanProfile> artisanProfiles = List.unmodifiable([
    ArtisanProfile(
      userId: 'artisan-1',
      companyName: 'Atelier Demo',
      registrationNumber: 'MOCK-FR-001',
      registrationCountryCode: 'FR',
      description: 'Entreprise fictive de peinture et de renovation interieure.',
      businessAdress: adress,
      tradeIds: {'trade-interior-painting'},
      serviceAreas: [ServiceArea(center: location, radiusInKm: 25)],
      yearsOfExperience: 8,
      hourlyRate: Money(minorUnits: 4500),
      websiteUrl: Uri.parse('https://artisan.example.test'),
      verificationStatus: VerificationStatus.verified,
    ),
  ]);

  static final requestPhoto = Attachment(
    id: 'attachment-request',
    uploadedByUserId: 'customer-1',
    fileName: 'salon-avant.jpg',
    mimeType: 'image/jpeg',
    url: Uri.parse('https://media.example.test/salon-avant.jpg'),
    kind: AttachmentKind.image,
    sizeInBytes: 120000,
    createdAt: createdAt,
  );
  static final portfolioPhoto = Attachment(
    id: 'attachment-portfolio',
    uploadedByUserId: 'artisan-1',
    fileName: 'salon-apres.jpg',
    mimeType: 'image/jpeg',
    url: Uri.parse('https://media.example.test/salon-apres.jpg'),
    kind: AttachmentKind.image,
    sizeInBytes: 140000,
    createdAt: DateTime.utc(2026, 10, 5, 16),
  );
  static final insuranceFile = Attachment(
    id: 'attachment-insurance',
    uploadedByUserId: 'artisan-1',
    fileName: 'assurance-demo.pdf',
    mimeType: 'application/pdf',
    url: Uri.parse('https://media.example.test/assurance-demo.pdf'),
    kind: AttachmentKind.document,
    sizeInBytes: 50000,
    createdAt: createdAt,
  );
  static final invoiceFile = Attachment(
    id: 'attachment-invoice',
    uploadedByUserId: 'artisan-1',
    fileName: 'facture-demo.pdf',
    mimeType: 'application/pdf',
    url: Uri.parse('https://media.example.test/facture-demo.pdf'),
    kind: AttachmentKind.document,
    sizeInBytes: 40000,
    createdAt: DateTime.utc(2026, 10, 5, 17),
  );
  static final List<Attachment> attachments = List.unmodifiable([requestPhoto, portfolioPhoto, insuranceFile, invoiceFile]);
  static final List<ProfessionalDocument> professionalDocuments = List.unmodifiable([
    ProfessionalDocument(
      id: 'document-insurance',
      artisanId: 'artisan-1',
      kind: ProfessionalDocumentKind.liabilityInsurance,
      title: 'Responsabilite civile professionnelle - demonstration',
      issuer: 'Assureur Demo',
      attachment: insuranceFile,
      issuedAt: createdAt,
      expiresAt: DateTime.utc(2027, 10, 1),
      verificationStatus: VerificationStatus.verified,
    ),
  ]);
  static final List<PortfolioProject> portfolioProjects = List.unmodifiable([
    PortfolioProject(
      id: 'portfolio-1',
      artisanId: 'artisan-1',
      title: 'Renovation du salon',
      description: 'Preparation des murs et peinture blanche.',
      tradeIds: {'trade-interior-painting'},
      media: [portfolioPhoto],
      completedAt: DateTime.utc(2026, 10, 5, 16),
      city: 'Paris',
    ),
  ]);

  static final firstPeriod = TimeSlot(startsAt: DateTime.utc(2026, 10, 5, 8), endsAt: DateTime.utc(2026, 10, 5, 16));
  static final secondPeriod = TimeSlot(startsAt: DateTime.utc(2026, 10, 8, 8), endsAt: DateTime.utc(2026, 10, 8, 16));
  static final List<WorkRequest> workRequests = List.unmodifiable([
    WorkRequest(
      id: 'request-1',
      customerId: 'customer-1',
      title: 'Repeindre le salon',
      description: 'Peinture blanche sur 20 metres carres de murs.',
      tradeIds: {'trade-interior-painting'},
      adress: adress,
      propertyType: PropertyType.apartment,
      status: WorkRequestStatus.closed,
      budget: Budget(minimum: Money(minorUnits: 100000), maximum: Money(minorUnits: 180000)),
      preferredPeriod: firstPeriod,
      attachments: [requestPhoto],
      createdAt: createdAt,
      updatedAt: firstPeriod.endsAt,
    ),
    WorkRequest(
      id: 'request-2',
      customerId: 'customer-1',
      title: 'Repeindre la cuisine',
      description: 'Preparation et peinture des murs de la cuisine.',
      tradeIds: {'trade-interior-painting'},
      adress: adress,
      propertyType: PropertyType.apartment,
      urgency: WorkUrgency.scheduled,
      status: WorkRequestStatus.assigned,
      budget: Budget(minimum: Money(minorUnits: 50000), maximum: Money(minorUnits: 80000)),
      preferredPeriod: secondPeriod,
      createdAt: createdAt,
      updatedAt: DateTime.utc(2026, 10, 2),
    ),
  ]);
  static final List<Quote> quotes = List.unmodifiable([
    Quote(
      id: 'quote-1',
      reference: 'DEV-DEMO-001',
      workRequestId: 'request-1',
      artisanId: 'artisan-1',
      customerId: 'customer-1',
      lines: [
        QuoteLine(
          description: 'Preparation et peinture du salon',
          quantity: 20,
          unit: QuoteUnit.squareMeter,
          unitPrice: Money(minorUnits: 5000),
          vatRateBasisPoints: 2000,
        ),
      ],
      status: QuoteStatus.accepted,
      createdAt: createdAt,
      validUntil: DateTime.utc(2026, 10, 31),
      proposedPeriod: firstPeriod,
      terms: 'Reglement a la fin des travaux.',
    ),
    Quote(
      id: 'quote-2',
      reference: 'DEV-DEMO-002',
      workRequestId: 'request-2',
      artisanId: 'artisan-1',
      customerId: 'customer-1',
      lines: [
        QuoteLine(
          description: 'Preparation et peinture de la cuisine',
          quantity: 10,
          unit: QuoteUnit.squareMeter,
          unitPrice: Money(minorUnits: 5000),
          vatRateBasisPoints: 2000,
        ),
      ],
      status: QuoteStatus.accepted,
      createdAt: createdAt,
      validUntil: DateTime.utc(2026, 10, 31),
      proposedPeriod: secondPeriod,
    ),
  ]);
  static final List<Job> jobs = List.unmodifiable([
    Job(
      id: 'job-1',
      workRequestId: 'request-1',
      acceptedQuoteId: 'quote-1',
      artisanId: 'artisan-1',
      customerId: 'customer-1',
      adress: adress,
      agreedTotal: quotes[0].total,
      scheduledPeriod: firstPeriod,
      status: JobStatus.completed,
      createdAt: DateTime.utc(2026, 10, 2),
      completedAt: firstPeriod.endsAt,
    ),
    Job(
      id: 'job-2',
      workRequestId: 'request-2',
      acceptedQuoteId: 'quote-2',
      artisanId: 'artisan-1',
      customerId: 'customer-1',
      adress: adress,
      agreedTotal: quotes[1].total,
      scheduledPeriod: secondPeriod,
      status: JobStatus.disputed,
      createdAt: DateTime.utc(2026, 10, 2),
    ),
  ]);
  static final List<Appointment> appointments = List.unmodifiable([
    Appointment(
      id: 'appointment-1',
      workRequestId: 'request-1',
      artisanId: 'artisan-1',
      customerId: 'customer-1',
      jobId: 'job-1',
      adress: adress,
      timeSlot: TimeSlot(startsAt: DateTime.utc(2026, 10, 3, 10), endsAt: DateTime.utc(2026, 10, 3, 11)),
      status: AppointmentStatus.completed,
      notes: 'Visite technique avant travaux.',
    ),
  ]);
  static final List<Availability> availabilities = List.unmodifiable([
    Availability(id: 'availability-1', artisanId: 'artisan-1', timeSlot: firstPeriod, status: AvailabilityStatus.unavailable),
    Availability(
      id: 'availability-2',
      artisanId: 'artisan-1',
      timeSlot: TimeSlot(startsAt: DateTime.utc(2026, 10, 12, 8), endsAt: DateTime.utc(2026, 10, 12, 17)),
      status: AvailabilityStatus.available,
    ),
  ]);

  static final List<Conversation> conversations = List.unmodifiable([
    Conversation(
      id: 'conversation-1',
      customerId: 'customer-1',
      artisanId: 'artisan-1',
      workRequestId: 'request-1',
      lastMessageId: 'message-2',
      createdAt: createdAt,
      updatedAt: createdAt.add(const Duration(hours: 2)),
    ),
  ]);
  static final List<Message> messages = List.unmodifiable([
    Message(
      id: 'message-1',
      conversationId: 'conversation-1',
      senderId: 'customer-1',
      text: 'Bonjour, voici une photo du salon.',
      attachments: [requestPhoto],
      sentAt: createdAt,
      readAt: createdAt.add(const Duration(hours: 1)),
    ),
    Message(
      id: 'message-2',
      conversationId: 'conversation-1',
      senderId: 'artisan-1',
      text: 'Bonjour, je vous propose une visite avant les travaux.',
      sentAt: createdAt.add(const Duration(hours: 2)),
    ),
  ]);
  static final List<Review> reviews = List.unmodifiable([
    Review(
      id: 'review-1',
      jobId: 'job-1',
      customerId: 'customer-1',
      artisanId: 'artisan-1',
      rating: 5,
      comment: 'Travail soigne et chantier propre.',
      createdAt: DateTime.utc(2026, 10, 6, 9),
      artisanReply: 'Merci pour votre retour.',
      repliedAt: DateTime.utc(2026, 10, 6, 10),
    ),
  ]);
  static final List<Invoice> invoices = List.unmodifiable([
    Invoice(
      id: 'invoice-1',
      number: 'FAC-DEMO-001',
      jobId: 'job-1',
      artisanId: 'artisan-1',
      customerId: 'customer-1',
      lines: quotes[0].lines,
      status: InvoiceStatus.paid,
      issuedAt: DateTime.utc(2026, 10, 5, 17),
      dueAt: DateTime.utc(2026, 10, 20),
      paidAt: DateTime.utc(2026, 10, 6),
      documentId: invoiceFile.id,
    ),
    Invoice(
      id: 'invoice-2',
      number: 'FAC-DEMO-002',
      jobId: 'job-2',
      artisanId: 'artisan-1',
      customerId: 'customer-1',
      lines: quotes[1].lines,
      status: InvoiceStatus.paid,
      issuedAt: DateTime.utc(2026, 10, 8, 17),
      dueAt: DateTime.utc(2026, 10, 23),
      paidAt: DateTime.utc(2026, 10, 9),
    ),
  ]);
  static final List<Payment> payments = List.unmodifiable([
    Payment(
      id: 'payment-1',
      invoiceId: 'invoice-1',
      customerId: 'customer-1',
      artisanId: 'artisan-1',
      amount: invoices[0].total,
      purpose: PaymentPurpose.full,
      status: PaymentStatus.succeeded,
      providerReference: 'mock-payment-1',
      createdAt: DateTime.utc(2026, 10, 6),
      paidAt: DateTime.utc(2026, 10, 6),
    ),
    Payment(
      id: 'payment-2',
      invoiceId: 'invoice-2',
      customerId: 'customer-1',
      artisanId: 'artisan-1',
      amount: invoices[1].total,
      purpose: PaymentPurpose.full,
      status: PaymentStatus.succeeded,
      providerReference: 'mock-payment-2',
      createdAt: DateTime.utc(2026, 10, 9),
      paidAt: DateTime.utc(2026, 10, 9),
    ),
  ]);
  static final List<Refund> refunds = List.unmodifiable([
    Refund(
      id: 'refund-1',
      paymentId: 'payment-2',
      amount: Money(minorUnits: 10000),
      reason: 'Geste commercial propose pour les finitions de la cuisine.',
      createdAt: DateTime.utc(2026, 10, 10),
    ),
  ]);
  static final List<Dispute> disputes = List.unmodifiable([
    Dispute(
      id: 'dispute-1',
      jobId: 'job-2',
      openedByUserId: 'customer-1',
      reason: 'Finitions',
      description: 'Une reprise des finitions de la cuisine est demandee.',
      status: DisputeStatus.underReview,
      createdAt: DateTime.utc(2026, 10, 9, 12),
    ),
  ]);
  static final List<Favorite> favorites = List.unmodifiable([Favorite(customerId: 'customer-1', artisanId: 'artisan-1', createdAt: createdAt)]);
  static final List<AppNotification> appNotifications = List.unmodifiable([
    AppNotification(
      id: 'notification-1',
      userId: 'customer-1',
      kind: NotificationKind.message,
      relatedEntityId: 'message-2',
      title: 'Nouveau message',
      body: 'Votre artisan vous propose une visite.',
      createdAt: createdAt.add(const Duration(hours: 2)),
    ),
    AppNotification(
      id: 'notification-2',
      userId: 'artisan-1',
      kind: NotificationKind.review,
      relatedEntityId: 'review-1',
      title: 'Nouvel avis',
      body: 'Un particulier vous a laisse un avis.',
      createdAt: DateTime.utc(2026, 10, 6, 9),
      readAt: DateTime.utc(2026, 10, 6, 10),
    ),
  ]);
}
