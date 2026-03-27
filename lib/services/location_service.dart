class LocationService {
  static const double _pi = 3.141592653589793;
  static const double _twoPi = 6.283185307179586;
  static const double _piOver2 = 1.5707963267948966;
  static const double _earthRadiusKm = 6371.0;
  static const int _sqrtIterations = 20;

  /// Returns the approximate distance in km between two lat/lng points
  /// using the Haversine formula (no external package required).
  double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    final dLat = _toRad(endLat - startLat);
    final dLng = _toRad(endLng - startLng);
    final a = _sin2(dLat / 2) +
        _cos(_toRad(startLat)) * _cos(_toRad(endLat)) * _sin2(dLng / 2);
    final c = 2 * _asin(_sqrt(a));
    return _earthRadiusKm * c;
  }

  double _toRad(double deg) => deg * _pi / 180.0;
  double _sin2(double x) => _sin(x) * _sin(x);
  double _sin(double x) => _sinApprox(x);
  double _cos(double x) => _sinApprox(x + _piOver2);
  double _asin(double x) => _asinApprox(x);
  double _sqrt(double x) => x <= 0 ? 0 : _sqrtApprox(x);

  double _sinApprox(double x) {
    // Normalize to [-π, π]
    while (x > _pi) x -= _twoPi;
    while (x < -_pi) x += _twoPi;
    return x - (x * x * x) / 6 + (x * x * x * x * x) / 120;
  }

  double _asinApprox(double x) {
    if (x >= 1.0) return _piOver2;
    if (x <= -1.0) return -_piOver2;
    return x + (x * x * x) / 6 + (3 * x * x * x * x * x) / 40;
  }

  double _sqrtApprox(double x) {
    double result = x;
    for (int i = 0; i < _sqrtIterations; i++) {
      result = (result + x / result) / 2;
    }
    return result;
  }
}