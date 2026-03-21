class Mileage {
  final String id;
  final String userId;
  final String projectId;
  final DateTime tripDate;
  final double distance;
  final double startLatitude;
  final double startLongitude;
  final double endLatitude;
  final double endLongitude;
  final String purpose;
  final DateTime createdAt;

  Mileage({
    required this.id,
    required this.userId,
    required this.projectId,
    required this.tripDate,
    required this.distance,
    required this.startLatitude,
    required this.startLongitude,
    required this.endLatitude,
    required this.endLongitude,
    required this.purpose,
    required this.createdAt,
  });
}