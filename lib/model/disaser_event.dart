class DisasterEvent {
  final String id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final String alertLevel;
  final String eventType;
  final String source;
  final DateTime? date;

  DisasterEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.alertLevel,
    required this.eventType,
    required this.source,
    this.date,
  });

  factory DisasterEvent.fromJson(Map<String, dynamic> json, String sourceName) {
    return DisasterEvent(
      id: json['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      latitude: double.tryParse(json['lat']?.toString() ?? '0') ?? 0,
      longitude: double.tryParse(json['lng']?.toString() ?? '0') ?? 0,
      alertLevel: json['alertlevel'] ?? '',
      eventType: json['eventtype'] ?? '',
      source: sourceName,
      date: json['pubDate'] != null
          ? DateTime.tryParse(json['pubDate'])
          : (json['time'] != null ? DateTime.fromMillisecondsSinceEpoch(json['time']) : DateTime.now()),
    );
  }

  /// Get a short location/country label for notifications (nearest country from coordinates).
  String get countryOrRegionLabel => getCountryNameFromLatLng(latitude, longitude);
}

/// Returns a human‑friendly location label from coordinates.
///
/// Some upstream feeds sometimes provide placeholders like `[unknown]` for the
/// country / region. Instead of surfacing that raw value to the user, this
/// helper always maps it to a friendlier fallback.
String getCountryNameFromLatLng(double lat, double lng) {
  if (worldCountries.isEmpty) return 'Global';

  String nearest = worldCountries.first.name;
  double minDist = _squaredDistance(
    lat,
    lng,
    worldCountries.first.latitude,
    worldCountries.first.longitude,
  );

  for (var c in worldCountries) {
    final d = _squaredDistance(lat, lng, c.latitude, c.longitude);
    if (d < minDist) {
      minDist = d;
      nearest = c.name;
    }
  }

  // Normalize any placeholder / empty labels to something user‑friendly.
  final normalized = nearest.trim();
  if (normalized.isEmpty ||
      normalized.toLowerCase() == 'unknown' ||
      normalized.toLowerCase() == '[unknown]') {
    return 'Global';
  }

  return normalized;
}

double _squaredDistance(double lat1, double lng1, double lat2, double lng2) {
  final a = lat1 - lat2;
  final b = lng1 - lng2;
  return a * a + b * b;
}

class CountryLabel {
  final String name;
  final double latitude;
  final double longitude;

  CountryLabel({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

final List<CountryLabel> worldCountries = [
  CountryLabel(name: 'USA', latitude: 37.0, longitude: -95.0),
  CountryLabel(name: 'Canada', latitude: 56.0, longitude: -106.0),
  CountryLabel(name: 'Mexico', latitude: 23.0, longitude: -102.0),
  CountryLabel(name: 'Brazil', latitude: -14.0, longitude: -51.0),
  CountryLabel(name: 'Argentina', latitude: -38.0, longitude: -63.0),
  CountryLabel(name: 'UK', latitude: 55.0, longitude: -3.0),
  CountryLabel(name: 'France', latitude: 46.0, longitude: 2.0),
  CountryLabel(name: 'Germany', latitude: 51.0, longitude: 10.0),
  CountryLabel(name: 'Spain', latitude: 40.0, longitude: -3.0),
  CountryLabel(name: 'Italy', latitude: 41.0, longitude: 12.0),
  CountryLabel(name: 'Russia', latitude: 61.0, longitude: 105.0),
  CountryLabel(name: 'China', latitude: 35.0, longitude: 105.0),
  CountryLabel(name: 'India', latitude: 20.0, longitude: 77.0),
  CountryLabel(name: 'Japan', latitude: 36.0, longitude: 138.0),
  CountryLabel(name: 'Australia', latitude: -25.0, longitude: 133.0),
  CountryLabel(name: 'South Africa', latitude: -30.0, longitude: 22.0),
  CountryLabel(name: 'Egypt', latitude: 26.0, longitude: 30.0),
  CountryLabel(name: 'Saudi Arabia', latitude: 23.0, longitude: 45.0),
  CountryLabel(name: 'Turkey', latitude: 38.0, longitude: 35.0),
  CountryLabel(name: 'Indonesia', latitude: -0.5, longitude: 117.0),
  CountryLabel(name: 'Thailand', latitude: 15.0, longitude: 100.0),
  CountryLabel(name: 'South Korea', latitude: 35.0, longitude: 127.0),
  CountryLabel(name: 'Nigeria', latitude: 9.0, longitude: 8.0),
  CountryLabel(name: 'Kenya', latitude: -0.0, longitude: 37.0),
  CountryLabel(name: 'Chile', latitude: -35.0, longitude: -71.0),
  CountryLabel(name: 'Peru', latitude: -9.0, longitude: -75.0),
  CountryLabel(name: 'Colombia', latitude: 4.0, longitude: -72.0),
  CountryLabel(name: 'Venezuela', latitude: 6.0, longitude: -66.0),
  CountryLabel(name: 'Poland', latitude: 51.0, longitude: 19.0),
  CountryLabel(name: 'Ukraine', latitude: 48.0, longitude: 31.0),
  CountryLabel(name: 'Iran', latitude: 32.0, longitude: 53.0),
  CountryLabel(name: 'Pakistan', latitude: 30.0, longitude: 69.0),
  CountryLabel(name: 'Bangladesh', latitude: 23.0, longitude: 90.0),
  CountryLabel(name: 'Vietnam', latitude: 14.0, longitude: 108.0),
  CountryLabel(name: 'Philippines', latitude: 12.0, longitude: 121.0),
  CountryLabel(name: 'Malaysia', latitude: 4.0, longitude: 101.0),
  CountryLabel(name: 'New Zealand', latitude: -40.0, longitude: 174.0),
];