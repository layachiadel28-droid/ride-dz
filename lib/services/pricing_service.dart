import 'dart:math' as math;

class PricingService {
  static const double pricePerKilometer = 10.0;

  static double calculateDistanceKm({
    required double pickupLat,
    required double pickupLng,
    required double dropoffLat,
    required double dropoffLng,
  }) {
    const earthRadiusKm = 6371.0;
    final dLat = _toRadians(dropoffLat - pickupLat);
    final dLng = _toRadians(dropoffLng - pickupLng);
    final lat1 = _toRadians(pickupLat);
    final lat2 = _toRadians(dropoffLat);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  static int calculatePrice({
    required double pickupLat,
    required double pickupLng,
    required double dropoffLat,
    required double dropoffLng,
  }) {
    final distanceKm = calculateDistanceKm(
      pickupLat: pickupLat,
      pickupLng: pickupLng,
      dropoffLat: dropoffLat,
      dropoffLng: dropoffLng,
    );

    return (distanceKm * pricePerKilometer).round();
  }

  static double _toRadians(double value) => value * math.pi / 180;
}
