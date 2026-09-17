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
        matches.add(
          DriverMatch(
            id: driver.id,
            distanceKm: distance,
          ),
        );
      }
    }

    matches.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    return matches;
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

    final a = (sin(dLat / 2) * sin(dLat / 2)) +
        (cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2));

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  static double _toRadians(double value) => value * 3.141592653589793 / 180;
}
