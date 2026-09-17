import 'dart:math' as math;

class DriverLocation {
  final String id;
  final double latitude;
  final double longitude;

  const DriverLocation({
    required this.id,
    required this.latitude,
    required this.longitude,
  });
}

class DriverMatch {
  final String id;
  final double distanceKm;

  const DriverMatch({
    required this.id,
    required this.distanceKm,
  });
}

class DriverMatchingService {
  static const double maxDistanceKm = 10;
  static const int maxDrivers = 5;

  static List<DriverMatch> findNearestDrivers({
    required double pickupLat,
    required double pickupLng,
    required List<DriverLocation> drivers,
  }) {
    final matches = <DriverMatch>[];

    for (final driver in drivers) {
      final distance = _distanceInKm(
        pickupLat,
        pickupLng,
        driver.latitude,
        driver.longitude,
      );

      if (distance <= maxDistanceKm) {
        matches.add(DriverMatch(id: driver.id, distanceKm: distance));
      }
    }

    matches.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return matches.take(maxDrivers).toList();
  }

  static double _distanceInKm(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadius = 6371.0;
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  static double _toRadians(double value) => value * math.pi / 180;
}
