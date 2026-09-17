enum RideStatus {
  requested,
  accepted,
  inProgress,
  completed,
  cancelled,
}

class RideModel {
  final String id;
  final String riderId;
  final String? driverId;
  final double pickupLat;
  final double pickupLng;
  final double dropoffLat;
  final double dropoffLng;
  final int offeredPrice;
  final RideStatus status;

  const RideModel({
    required this.id,
    required this.riderId,
    this.driverId,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropoffLat,
    required this.dropoffLng,
    required this.offeredPrice,
    required this.status,
  });

  factory RideModel.fromMap(Map<String, dynamic> map) {
    return RideModel(
      id: map['id'] ?? '',
      riderId: map['riderId'] ?? '',
      driverId: map['driverId'],
      pickupLat: (map['pickupLat'] ?? 0.0).toDouble(),
      pickupLng: (map['pickupLng'] ?? 0.0).toDouble(),
      dropoffLat: (map['dropoffLat'] ?? 0.0).toDouble(),
      dropoffLng: (map['dropoffLng'] ?? 0.0).toDouble(),
      offeredPrice: map['offeredPrice'] ?? 0,
      status: RideStatus.values.firstWhere(
        (item) => item.name == (map['status'] ?? 'requested'),
        orElse: () => RideStatus.requested,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'riderId': riderId,
      'driverId': driverId,
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'dropoffLat': dropoffLat,
      'dropoffLng': dropoffLng,
      'offeredPrice': offeredPrice,
      'status': status.name,
    };
  }
}
