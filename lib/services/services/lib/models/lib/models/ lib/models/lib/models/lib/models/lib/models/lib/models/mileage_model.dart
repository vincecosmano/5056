class Mileage {
  final String id;
  final String userId;
  final double distance;
  final String startLocation;
  final String endLocation;
  final DateTime date;
  final String? notes;

  Mileage({
    required this.id,
    required this.userId,
    required this.distance,
    required this.startLocation,
    required this.endLocation,
    required this.date,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'distance': distance,
      'startLocation': startLocation,
      'endLocation': endLocation,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }

  factory Mileage.fromMap(Map<String, dynamic> map) {
    return Mileage(
      id: map['id'],
      userId: map['userId'],
      distance: map['distance'],
      startLocation: map['startLocation'],
      endLocation: map['endLocation'],
      date: DateTime.parse(map['date']),
      notes: map['notes'],
    );
  }
}
