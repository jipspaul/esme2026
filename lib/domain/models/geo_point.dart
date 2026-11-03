class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint({required this.latitude, required this.longitude}) {
    if (!latitude.isFinite || latitude < -90 || latitude > 90) {
      throw ArgumentError.value(latitude, 'latitude', 'Expected -90 to 90');
    }
    if (!longitude.isFinite || longitude < -180 || longitude > 180) {
      throw ArgumentError.value(longitude, 'longitude', 'Expected -180 to 180');
    }
  }
}
