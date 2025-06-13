import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:senatorgo/data/database.dart';

// Represents a point with x and y coordinates
class Point {
  final double x, y;
  Point(this.x, this.y);
}

// Main class for geographic lookup and senator finding
class Geofinder {
  // Stores loaded geographic data (GeoJSON)
  Map<String, dynamic> _data = {};
  // Stores loaded senators data
  Map<String, dynamic> _senators = {};
  // Not used in current code, but can hold features
  List<List<dynamic>> features = [];

  // Instance of the SenatorDatabase for senator records
  final db = SenatorDatabase();

  // Loads geographic data from a JSON asset file
  Future<void> loadData(String path) async {
    String data = await rootBundle.loadString(path);
    _data = json.decode(data);
  }

  // Loads senators data from a JSON asset file
  Future<void> loadSenators(String path) async {
    String data = await rootBundle.loadString(path);
    _senators = json.decode(data);
  }

  // Finds a senator by district properties
  Map<String, dynamic>? findSenator(Map<String, dynamic>? properties) {
    if (properties == null) return null;

    // Get the district number from the properties
    final int district = int.parse(properties['OBVOD']);
    // Search for the senator with the matching district
    for (var senator in _senators['senators']) {
      if (senator['district'] == district) {
        return senator;
      }
    }
    return null;
  }

  // Finds the properties of the feature (district) containing the given coordinates
  Map<String, dynamic>? getLocationProperties(Point coordinates) {
    final features = _getFeatures();

    // Loop through all features (districts)
    for (var i = 0; i < features.length; i++) {
      final List<dynamic> featureCoordinates = _getFeatureCoordinates(i);
      if (featureCoordinates.isEmpty) {
        continue;
      }

      // The first ring is the exterior boundary
      final exterior = featureCoordinates[0];
      List<Point> exteriorPoints = exterior.map<Point>((coord) {
        return Point(
          (coord[1] as num).toDouble(),
          (coord[0] as num).toDouble(),
        );
      }).toList();

      // Check if the point is inside the exterior boundary
      if (!_isPointInPolygon(coordinates, exteriorPoints)) {
        continue;
      }

      // Check if the point is inside any hole (interior ring)
      bool inHole = false;
      for (int j = 1; j < featureCoordinates.length; j++) {
        final interior = featureCoordinates[j];
        List<Point> interiorPoints = interior.map<Point>((coord) {
          return Point(
            (coord[1] as num).toDouble(),
            (coord[0] as num).toDouble(),
          );
        }).toList();

        if (_isPointInPolygon(coordinates, interiorPoints)) {
          inHole = true;
          break;
        }
      }

      // If the point is not in a hole, return the properties of this feature
      if (!inHole) {
        return _getFeatureProperties(i);
      }
    }

    // No matching feature found
    return null;
  }

  // Ray-casting algorithm to determine if a point is inside a polygon
  bool _isPointInPolygon(Point point, List<Point> polygon) {
    bool inside = false;
    int n = polygon.length;
    int j = n - 1;

    for (int i = 0; i < n; i++) {
      double xi = polygon[i].x, yi = polygon[i].y;
      double xj = polygon[j].x, yj = polygon[j].y;

      // Check if the point crosses the edge of the polygon.
      bool intersect = ((yi > point.y) != (yj > point.y)) &&
          (point.x < (xj - xi) * (point.y - yi) / (yj - yi) + xi);

      if (intersect) inside = !inside;
      j = i;
    }

    return inside;
  }

  // Loads polygons for all districts and colors them based on senator data
  Future<List<Polygon>> loadSenatorsCollection(
      String destrictsPath, String senatorsPath) async {
    // Load geographic and senator data
    await loadData(destrictsPath);
    await loadSenators(senatorsPath);
    db.loadData();

    final data = await rootBundle.loadString(destrictsPath);
    final geoJson = json.decode(data);

    final List<Polygon> tempPolygons = [];

    // Loop through all features (districts)
    for (var feature in geoJson['features']) {
      final List<dynamic> allRings = feature['geometry']['coordinates'];

      // Each ring represents a polygon (exterior or hole)
      for (var ring in allRings) {
        // Convert coordinates to LatLng points
        final polygonPoints = ring.map<LatLng>((c) {
          return LatLng(
            (c[1] as num).toDouble(),
            (c[0] as num).toDouble(),
          );
        }).toList();

        final properties = feature['properties'];
        final senator = findSenator(properties);

        // Set color based on whether the senator is in the database
        Color color;
        if (senator == null) {
          color = const Color.fromARGB(135, 54, 54, 54);
        } else if (db.containsRecord(senator["district"], senator["mandate"])) {
          color = const Color(0xff003876);
        } else {
          color = const Color.fromARGB(135, 54, 54, 54);
        }

        // Add the polygon to the list
        tempPolygons.add(
          Polygon(
            points: polygonPoints,
            color: color,
            isFilled: true,
            borderColor: const Color.fromARGB(255, 255, 255, 255),
            borderStrokeWidth: 3.0,
          ),
        );
      }
    }

    return tempPolygons;
  }

  // Returns the list of features from the loaded GeoJSON data
  List<dynamic> _getFeatures() {
    return _data['features'];
  }

  // Returns the properties of a feature by index
  Map<String, dynamic> _getFeatureProperties(int index) {
    return _data['features'][index]['properties'];
  }

  // Returns the coordinates of a feature by index
  List<dynamic> _getFeatureCoordinates(int index) {
    return _data['features'][index]['geometry']['coordinates'];
  }

  // Returns the release date from the senators data
  String getReleaseDate() {
    return _senators["releaseDate"];
  }
}
