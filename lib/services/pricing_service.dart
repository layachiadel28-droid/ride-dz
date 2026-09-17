class PricingService {
  static const double pricePerKilometer = 10.0;

  static int calculatePrice({
    required double pickupLat,
    required double pickupLng,
    required double dropoffLat,
    required double dropoffLng,
  }) {
    final distanceKm = _calculateDistanceKm(
      pickupLat: pickupLat,
      pickupLng: pickupLng,
      dropoffLat: dropoffLat,
      dropoffLng: dropoffLng,
    );

    return (distanceKm * pricePerKilometer).round();
  }

  static double _calculateDistanceKm({
    required double pickupLat,
    required double pickupLng,
    required double dropoffLat,
    required double dropoffLng,
  }) {
    final latDistance = (dropoffLat - pickupLat) * 111.32;
    final lngDistance = (dropoffLng - pickupLng) * 111.32;
    return (latDistance * latDistance + lngDistance * lngDistance)
        .abs()
        .sqrt();
  }
}
