import 'package:esme26/domain/models/adress.dart';
import 'package:esme26/domain/models/geo_point.dart';
import 'package:esme26/domain/models/money.dart';

enum VerificationStatus { pending, verified, rejected, expired }

class ServiceArea {
  final GeoPoint center;
  final double radiusInKm;

  ServiceArea({required this.center, required this.radiusInKm}) {
    if (!radiusInKm.isFinite || radiusInKm <= 0) {
      throw ArgumentError.value(radiusInKm, 'radiusInKm', 'Must be positive');
    }
  }
}

class ArtisanProfile {
  final String userId;
  final String companyName;
  final String registrationNumber;
  final String registrationCountryCode;
  final String? vatNumber;
  final String description;
  final Adress businessAdress;
  final Set<String> tradeIds;
  final List<ServiceArea> serviceAreas;
  final int yearsOfExperience;
  final Money? hourlyRate;
  final Uri? websiteUrl;
  final VerificationStatus verificationStatus;
  final bool acceptingNewRequests;

  ArtisanProfile({
    required this.userId,
    required this.companyName,
    required this.registrationNumber,
    required this.registrationCountryCode,
    this.vatNumber,
    required this.description,
    required this.businessAdress,
    required Set<String> tradeIds,
    required List<ServiceArea> serviceAreas,
    required this.yearsOfExperience,
    this.hourlyRate,
    this.websiteUrl,
    this.verificationStatus = VerificationStatus.pending,
    this.acceptingNewRequests = true,
  }) : tradeIds = Set.unmodifiable(tradeIds),
       serviceAreas = List.unmodifiable(serviceAreas) {
    if (tradeIds.isEmpty || serviceAreas.isEmpty) {
      throw ArgumentError('An artisan needs a trade and a service area');
    }
    if (yearsOfExperience < 0) {
      throw ArgumentError.value(
        yearsOfExperience,
        'yearsOfExperience',
        'Must be non-negative',
      );
    }
  }
}
