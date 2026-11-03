import 'package:esme26/domain/models/geo_point.dart';

class Adress {
  final String street;
  final String city;
  final String postalCode;
  final String country;
  final String? complement;
  final GeoPoint? location;

  const Adress({
    required this.street,
    required this.city,
    required this.postalCode,
    required this.country,
    this.complement,
    this.location,
  });
}
