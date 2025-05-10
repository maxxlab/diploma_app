// lib/services/mapbox_service.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../models/poi.dart';

class MapboxService {
  // Convert POIs to GeoJSON
  static String poisToGeoJson(List<POI> pois) {
    final features = pois
        .map((poi) => {
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
            })
        .toList();

    final featureCollection = {
      'type': 'FeatureCollection',
      'features': features,
    };

    return jsonEncode(featureCollection);
  }

  // Add point annotations for POIs
  static Future<PointAnnotationManager?> addPOIAnnotations(
    MapboxMap mapboxMap,
    List<POI> pois,
    Function(PointAnnotation) onTap,
  ) async {
    try {
      // Create point annotation manager
      final pointAnnotationManager =
          await mapboxMap.annotations.createPointAnnotationManager();

      final ByteData bytes = await rootBundle.load('assets/images/map_pin.png');
      final Uint8List imageData = bytes.buffer.asUint8List();

      // Create point annotations from POIs
      for (final poi in pois) {
        final point = Point(
          coordinates: Position(
            poi.location.longitude,
            poi.location.latitude,
          ),
        );

        final pointAnnotationOptions = PointAnnotationOptions(
          geometry: point,
          iconSize: 0.15,
          image: imageData,
          textField: poi.name,
          textSize: 12.0,
          textOffset: [0, 1.5],
          // textColor: "#000000",
        );

        // Create the annotation
        await pointAnnotationManager.create(pointAnnotationOptions);

        pointAnnotationManager.addOnPointAnnotationClickListener(
          AnnotationClickListener(
            pointAnnotationManager: pointAnnotationManager,
            onAnnotationTap: onTap,
            mapboxMap: mapboxMap,
          ),
        );
      }

      return pointAnnotationManager;
    } catch (e) {
      print('Error adding POI annotations: $e');
      return null;
    }
  }

  // Helper to get color for POI category
  static String getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'historical':
        return "#964B00"; // Brown
      case 'museum':
        return "#9370DB"; // Purple
      case 'restaurant':
        return "#FF4500"; // Orange Red
      case 'cafe':
        return "#8B4513"; // Saddle Brown
      case 'viewpoint':
        return "#1E90FF"; // Dodger Blue
      default:
        return "#000000"; // Black
    }
  }
}

class AnnotationClickListener extends OnPointAnnotationClickListener {
  final MapboxMap mapboxMap;
  final PointAnnotationManager pointAnnotationManager;
  final void Function(PointAnnotation annotation)? onAnnotationTap;

  AnnotationClickListener({
    required this.mapboxMap,
    required this.pointAnnotationManager,
    this.onAnnotationTap,
  });

  @override
  bool onPointAnnotationClick(PointAnnotation annotation) {
    print("Annotation clicked at: ${annotation.geometry}");

    if (onAnnotationTap != null) {
      onAnnotationTap!(annotation);
    }

    return true;
  }
}
