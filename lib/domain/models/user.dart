import 'package:esme26/domain/models/adress.dart';

enum UserRole { customer, artisan }

enum AccountStatus { active, suspended, closed }

class User {
  /// Null until the onboarding draft is persisted.
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final int birthDateInMillisFromEpoch;
  final Adress adress;
  final String? phoneNumber;
  final Uri? avatarUrl;
  final Set<UserRole> roles;
  final AccountStatus status;
  final DateTime? createdAt;

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDateInMillisFromEpoch,
    required this.adress,
    this.phoneNumber,
    this.avatarUrl,
    Set<UserRole> roles = const {UserRole.customer},
    this.status = AccountStatus.active,
    this.createdAt,
  }) : roles = Set.unmodifiable(roles) {
    if (roles.isEmpty) {
      throw ArgumentError.value(roles, 'roles', 'At least one role is required');
    }
  }
}
