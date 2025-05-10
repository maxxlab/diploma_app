// lib/utils/geojson_converter.dart
import 'dart:convert';
import 'package:tourist_app/models/poi.dart'; // Import Firebase GeoPoint

class GeoJsonConverter {
  // Convert a single POI to GeoJSON feature
  static Map<String, dynamic> poiToFeature(POI poi) {
    return {
      'type': 'Feature',
      'geometry': {
        'type': 'Point',
        'coordinates': [poi.location.longitude, poi.location.latitude]
      },
      'properties': {
        'id': poi.id,
        'name': poi.name,
        'description': poi.description,
        'category': poi.category,
        'rating': poi.averageRating,
      }
    };
  }

  // Convert a list of POIs to GeoJSON feature collection
  static String poisToFeatureCollection(List<POI> pois) {
    final featureCollection = {
      'type': 'FeatureCollection',
      'features': pois.map((poi) => poiToFeature(poi)).toList(),
    };

    return jsonEncode(featureCollection);
  }
}