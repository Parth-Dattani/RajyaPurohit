import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../model/model.dart';

/// Backend that serves [api/proxy.js] (e.g. compassiona-backend on Vercel).
/// Override at build time: `--dart-define=PROXY_BASE_URL=https://your-domain`.
const String _proxyBaseUrl = String.fromEnvironment(
  'PROXY_BASE_URL',
  defaultValue: 'https://compassiona-backend.vercel.app',
);

/// On web, call feeds through same-origin proxy to avoid CORS.
String _proxyUrl(String targetUrl) {
  if (!kIsWeb) return targetUrl;
  final base = _proxyBaseUrl.isNotEmpty ? _proxyBaseUrl : Uri.base.origin;
  return '$base/api/proxy?url=${Uri.encodeComponent(targetUrl)}';
}

String _cleanUnknownPlaceholders(String text) {
  if (text.isEmpty) return text;
  return text
      .replaceAll(RegExp(r'\[\s*unknown\s*\]', caseSensitive: false), '')
      .replaceAll(RegExp(r'\bunknown\b', caseSensitive: false), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(RegExp(r'\s+,', caseSensitive: false), ',')
      .replaceAll(RegExp(r',\s+,', caseSensitive: false), ',')
      .replaceAll(RegExp(r',\s*\.', caseSensitive: false), '.')
      .trim();
}

//
// // A. GDACS (Global: Hurricanes, Floods, Droughts)
// Future<List<DisasterEvent>> parseGdacsData(String responseBody) async {
//   final document = XmlDocument.parse(responseBody);
//   final items = document.findAllElements('item');
//   List<DisasterEvent> events = [];
//
//   for (var item in items) {
//     final point = item.findElements('georss:point').firstOrNull?.innerText;
//     final title = item.findElements('title').firstOrNull?.innerText ?? "Unknown";
//     final desc = item.findElements('description').firstOrNull?.innerText ?? "";
//     final alert = item.findElements('gdacs:alertlevel').firstOrNull?.innerText ?? "Green";
//     final type = item.findElements('gdacs:eventtype').firstOrNull?.innerText ?? "Gen";
//
//     if (point != null) {
//       final coords = point.split(' ');
//       events.add(DisasterEvent(
//         title: title,
//         description: desc,
//         latitude: double.parse(coords[0]),
//         longitude: double.parse(coords[1]),
//         alertLevel: alert,
//         eventType: type,
//         source: "GDACS",
//       ));
//     }
//   }
//   return events;
// }
//
// class GdacsService {
//   static const String _rssUrl = 'https://www.gdacs.org/xml/rss.xml';
//   static String get url => kIsWeb ? 'https://cors-anywhere.herokuapp.com/$_rssUrl' : _rssUrl;
//
//   static Future<List<DisasterEvent>> fetch() async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) return await compute(parseGdacsData, response.body);
//     } catch (e) { debugPrint("GDACS Error: $e"); }
//     return [];
//   }
// }
//
// // B. USGS (Global: Earthquakes)
// Future<List<DisasterEvent>> parseUsgsData(String responseBody) async {
//   final data = json.decode(responseBody);
//   final features = data['features'] as List;
//   List<DisasterEvent> events = [];
//
//   for (var feature in features) {
//     final props = feature['properties'];
//     final coords = feature['geometry']['coordinates'];
//     final mag = (props['mag'] as num).toDouble();
//     String alert = mag > 7.0 ? "Red" : (mag > 6.0 ? "Orange" : "Green");
//
//     events.add(DisasterEvent(
//       title: "M $mag - ${props['place']}",
//       description: "Time: ${DateTime.fromMillisecondsSinceEpoch(props['time'])}",
//       latitude: coords[1].toDouble(),
//       longitude: coords[0].toDouble(),
//       alertLevel: alert,
//       eventType: "EQ",
//       source: "USGS",
//     ));
//   }
//   return events;
// }
//
// class UsgsService {
//   static const String _url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_day.geojson';
//   static Future<List<DisasterEvent>> fetch() async {
//     try {
//       final response = await http.get(Uri.parse(_url));
//       if (response.statusCode == 200) return await compute(parseUsgsData, response.body);
//     } catch (e) { debugPrint("USGS Error: $e"); }
//     return [];
//   }
// }
//
// // C. NASA EONET (Global: Wildfires, Volcanoes)
// Future<List<DisasterEvent>> parseNasaData(String responseBody) async {
//   final data = json.decode(responseBody);
//   final eventsList = data['events'] as List;
//   List<DisasterEvent> events = [];
//
//   for (var event in eventsList) {
//     final title = event['title'];
//     final geometry = event['geometry'];
//     if (geometry == null || (geometry as List).isEmpty) continue;
//
//     final coords = geometry[0]['coordinates'];
//     final catId = event['categories'][0]['id'];
//
//     String type = "OT";
//     if (catId == 'wildfires') type = "WF";
//     if (catId == 'volcanoes') type = "VO";
//
//     events.add(DisasterEvent(
//       title: title,
//       description: "Source: NASA EONET",
//       latitude: coords[1].toDouble(),
//       longitude: coords[0].toDouble(),
//       alertLevel: "Orange",
//       eventType: type,
//       source: "NASA",
//     ));
//   }
//   return events;
// }
//
// class NasaService {
//   static const String _url = 'https://eonet.gsfc.nasa.gov/api/v3/events?category=wildfires,volcanoes&days=10';
//   static String get url => kIsWeb ? 'https://cors-anywhere.herokuapp.com/$_url' : _url;
//
//   static Future<List<DisasterEvent>> fetch() async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) return await compute(parseNasaData, response.body);
//     } catch (e) { debugPrint("NASA Error: $e"); }
//     return [];
//   }
// }
//
// // D. NOAA (US: Tornadoes, Severe Weather)
// Future<List<DisasterEvent>> parseNoaaData(String responseBody) async {
//   final data = json.decode(responseBody);
//   final features = data['features'] as List;
//   List<DisasterEvent> events = [];
//
//   for (var feature in features) {
//     final props = feature['properties'];
//     final eventName = props['event'] as String;
//
//     String type = "SW";
//     String alert = "Orange";
//
//     if (eventName.contains("Tornado")) { type = "TO"; alert = "Red"; }
//     else if (eventName.contains("Flood")) { type = "FL"; }
//     else if (eventName.contains("Hurricane")) { type = "TC"; alert = "Red"; }
//     else if (eventName.contains("Fire")) { type = "WF"; alert = "Red"; }
//
//     final geometry = feature['geometry'];
//     double? centerLat, centerLng;
//
//     if (geometry != null) {
//       if (geometry['type'] == 'Polygon') {
//         final coords = geometry['coordinates'][0][0];
//         centerLat = coords[1].toDouble();
//         centerLng = coords[0].toDouble();
//       } else if (geometry['type'] == 'Point') {
//         final coords = geometry['coordinates'];
//         centerLat = coords[1].toDouble();
//         centerLng = coords[0].toDouble();
//       }
//     }
//
//     if (centerLat != null && centerLng != null) {
//       events.add(DisasterEvent(
//         title: eventName,
//         description: "${props['headline'] ?? props['description']}",
//         latitude: centerLat,
//         longitude: centerLng,
//         alertLevel: alert,
//         eventType: type,
//         source: "NOAA",
//       ));
//     }
//   }
//   return events;
// }
//
// class NoaaService {
//   static const String _url = 'https://api.weather.gov/alerts/active?severity=Severe,Extreme';
//
//   static Future<List<DisasterEvent>> fetch() async {
//     try {
//       final response = await http.get(
//         Uri.parse(_url),
//         headers: {'User-Agent': 'GlobalCompassionApp (contact@example.com)'},
//       );
//       if (response.statusCode == 200) return await compute(parseNoaaData, response.body);
//     } catch (e) { debugPrint("NOAA Error: $e"); }
//     return [];
//   }
// }


DateTime? _parseHttpDate(String dateStr) {
  try {
    final months = {
      'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
      'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
    };
    final parts = dateStr.replaceAll(',', '').trim().split(RegExp(r'\s+'));
    if (parts.length < 5) return null;
    final day = int.parse(parts[1]);
    final month = months[parts[2]] ?? 1;
    final year = int.parse(parts[3]);
    final timeParts = parts[4].split(':');
    return DateTime.utc(year, month, day,
        int.parse(timeParts[0]), int.parse(timeParts[1]));
  } catch (_) {
    return null;
  }
}

///isolate

class GdacsService {
  static const String _rssUrl = 'https://www.gdacs.org/xml/rss.xml';
  static String get url => _proxyUrl(_rssUrl);

  static Future<List<DisasterEvent>> fetch() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return await compute(parseGdacsData, response.body);
      }
    } catch (e) {
      debugPrint("GDACS Fetch Error: $e");
    }
    return [];
  }
}


// --- A. GDACS ---
Future<List<DisasterEvent>> parseGdacsData(String responseBody) async {
  List<DisasterEvent> events = [];
  try {
    final document = XmlDocument.parse(responseBody);
    final items = document.findAllElements('item');

    for (var item in items) {
      try {
        final guid = item.findElements('guid').firstOrNull?.innerText;
        final eventId = item.findElements('gdacs:eventid').firstOrNull?.innerText;
        final point = item.findElements('georss:point').firstOrNull?.innerText;
        final rawTitle = item.findElements('title').firstOrNull?.innerText ?? "Unknown Event";
        final rawDesc = item.findElements('description').firstOrNull?.innerText ?? "No description available.";
        final title = _cleanUnknownPlaceholders(rawTitle);
        final desc = _cleanUnknownPlaceholders(rawDesc);
        final alert = item.findElements('gdacs:alertlevel').firstOrNull?.innerText ?? "Green";
        final type = item.findElements('gdacs:eventtype').firstOrNull?.innerText ?? "Gen";
        final pubDateStr = item.findElements('pubDate').firstOrNull?.innerText;

        // ✅ Proper date parse — DateTime.now() fallback nahi
        DateTime? parsedDate;
        if (pubDateStr != null) {
          parsedDate = DateTime.tryParse(pubDateStr) ?? _parseHttpDate(pubDateStr);
        }

        if (point != null) {
          final coords = point.trim().split(' ');
          if (coords.length >= 2) {
            events.add(DisasterEvent(
              id: guid ?? eventId ?? "${rawTitle}_${coords[0]}",
              title: title,
              description: desc,
              latitude: double.parse(coords[0]),
              longitude: double.parse(coords[1]),
              alertLevel: alert,
              eventType: type,
              source: "GDACS",
              date: parsedDate, // ✅ null raheva do jya date na hoy
            ));
          }
        }
      } catch (e) {
        debugPrint("Error parsing single GDACS item: $e");
      }
    }
  } catch (e) {
    debugPrint("GDACS Critical Parse Error: $e");
  }
  return events;
}

// --- B. USGS SERVICE (Safe JSON Access) ---
Future<List<DisasterEvent>> parseUsgsData(String responseBody) async {
  List<DisasterEvent> events = [];
  try {
    final data = json.decode(responseBody);
    final features = data['features'] as List?;
    if (features == null) return [];

    for (var feature in features) {
      try {
        final props = feature['properties'];
        final geometry = feature['geometry'];
        if (props == null || geometry == null) continue;

        final coords = geometry['coordinates'];
        if (coords == null || (coords as List).length < 2) continue;

        final mag = (props['mag'] as num?)?.toDouble() ?? 0.0;
        String alert = mag > 7.0 ? "Red" : (mag > 6.0 ? "Orange" : "Green");

        // ✅ Actual earthquake timestamp
        final eventTime = props['time'] != null
            ? DateTime.fromMillisecondsSinceEpoch(props['time'] as int, isUtc: true)
            : null;

        events.add(DisasterEvent(
          id: props['id'] ?? props['code'] ?? "USGS_${props['time']}",
          title: "M $mag - ${props['place'] ?? 'Unknown Location'}",
          description: '', // ✅ timestamp description ma nahi
          latitude: (coords[1] as num).toDouble(),
          longitude: (coords[0] as num).toDouble(),
          alertLevel: alert,
          eventType: "EQ",
          source: "USGS",
          date: eventTime, // ✅ Actual time
        ));
      } catch (e) {
        debugPrint("Error parsing single USGS item: $e");
      }
    }
  } catch (e) {
    debugPrint("USGS Critical Parse Error: $e");
  }
  return events;
}

class UsgsService {
  static const String _url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_day.geojson';

  static Future<List<DisasterEvent>> fetch() async {
    try {
      final response = await http.get(Uri.parse(_proxyUrl(_url)));
      if (response.statusCode == 200) {
        return await compute(parseUsgsData, response.body);
      }
    } catch (e) {
      debugPrint("USGS Fetch Error: $e");
    }
    return [];
  }
}

// --- C. NASA EONET (Added Category Safety) ---
Future<List<DisasterEvent>> parseNasaData(String responseBody) async {
  List<DisasterEvent> events = [];
  try {
    final data = json.decode(responseBody);
    final eventsList = data['events'] as List?;
    if (eventsList == null) return [];

    for (var event in eventsList) {
      try {
        final title = event['title'] ?? "Unknown Event";
        final geometry = event['geometry'] as List?;
        final categories = event['categories'] as List?;
        final eventId = event['id'] ?? "NASA_${DateTime.now().millisecondsSinceEpoch}";

        if (geometry == null || geometry.isEmpty) continue;

        String type = "OT";
        if (categories != null && categories.isNotEmpty) {
          final catId = categories[0]['id'];
          if (catId == 'wildfires') type = "WF";
          else if (catId == 'volcanoes') type = "VO";
          else if (catId == 'severeStorms') type = "TC";
        }

        final coords = geometry[0]['coordinates'];
        if (coords == null || (coords as List).length < 2) continue;

        // ✅ Actual event date from geometry
        final dateStr = geometry[0]['date'] as String?;
        final eventDate = dateStr != null ? DateTime.tryParse(dateStr) : null;

        events.add(DisasterEvent(
          id: eventId,
          title: title,
          description: "Source: NASA EONET",
          latitude: (coords[1] as num).toDouble(),
          longitude: (coords[0] as num).toDouble(),
          alertLevel: "Orange",
          eventType: type,
          source: "NASA",
          date: eventDate, // ✅ Actual date
        ));
      } catch (e) {
        debugPrint("Error parsing single NASA item: $e");
      }
    }
  } catch (e) {
    debugPrint("NASA Critical Parse Error: $e");
  }
  return events;
}

class NasaService {
  static const String _url = 'https://eonet.gsfc.nasa.gov/api/v3/events?category=wildfires,volcanoes&days=10';
  static String get url => _proxyUrl(_url);

  static Future<List<DisasterEvent>> fetch() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return await compute(parseNasaData, response.body);
      }
    } catch (e) {
      debugPrint("NASA Fetch Error: $e");
    }
    return [];
  }
}

// --- D. NOAA (Complex Geometry Handling) ---
Future<List<DisasterEvent>> parseNoaaData(String responseBody) async {
  List<DisasterEvent> events = [];
  try {
    final data = json.decode(responseBody);
    final features = data['features'] as List?;
    if (features == null) return [];

    for (var feature in features) {
      try {
        final props = feature['properties'];
        if (props == null) continue;

        final eventName = props['event'] as String? ?? "Unknown Alert";

        String type = "SW";
        String alert = "Orange";

        if (eventName.contains("Tornado")) { type = "TO"; alert = "Red"; }
        else if (eventName.contains("Flood")) { type = "FL"; }
        else if (eventName.contains("Hurricane")) { type = "TC"; alert = "Red"; }
        else if (eventName.contains("Fire")) { type = "WF"; alert = "Red"; }

        final geometry = feature['geometry'];
        if (geometry == null) continue;

        double? centerLat, centerLng;

        if (geometry['type'] == 'Polygon') {
          final coords = geometry['coordinates'];
          if (coords != null && (coords as List).isNotEmpty) {
            final firstPoint = coords[0][0];
            centerLat = (firstPoint[1] as num).toDouble();
            centerLng = (firstPoint[0] as num).toDouble();
          }
        } else if (geometry['type'] == 'Point') {
          final coords = geometry['coordinates'];
          if (coords != null && (coords as List).length >= 2) {
            centerLat = (coords[1] as num).toDouble();
            centerLng = (coords[0] as num).toDouble();
          }
        }

        if (centerLat != null && centerLng != null) {
          // ✅ Actual alert date
          final dateStr = props['onset'] as String? ?? props['effective'] as String?;
          final eventDate = dateStr != null ? DateTime.tryParse(dateStr) : null;

          events.add(DisasterEvent(
            id: props['id'] ?? props['identifier'] ?? "${eventName}_$centerLat",
            title: eventName,
            description: "${props['headline'] ?? props['description'] ?? 'No details'}",
            latitude: centerLat,
            longitude: centerLng,
            alertLevel: alert,
            eventType: type,
            source: "NOAA",
            date: eventDate, // ✅ Actual date
          ));
        }
      } catch (e) {
        debugPrint("Error parsing single NOAA item: $e");
      }
    }
  } catch (e) {
    debugPrint("NOAA Critical Parse Error: $e");
  }
  return events;
}

class NoaaService {
  static const String _url = 'https://api.weather.gov/alerts/active?severity=Severe,Extreme';

  static Future<List<DisasterEvent>> fetch() async {
    try {
      final response = await http.get(
        Uri.parse(_proxyUrl(_url)),
        // NOAA requires a User-Agent or it will return 403 Forbidden
        headers: {'User-Agent': 'GlobalCompassionApp (contact@example.com)'},
      );
      if (response.statusCode == 200) {
        return await compute(parseNoaaData, response.body);
      } else {
        debugPrint("NOAA Fetch Failed: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("NOAA Fetch Error: $e");
    }
    return [];
  }
}