// lib/services/mapbox_service.dart
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../models/poi.dart';

class MapboxService {
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

  Future<PointAnnotationManager> addPOIAnnotations(
      MapboxMap mapboxMap,
      List<POI> pois,
      Function(PointAnnotation) onTap,
      ) async {
    try {
      final pointAnnotationManager =
      await mapboxMap.annotations.createPointAnnotationManager();

      final ByteData bytes = await rootBundle.load('assets/images/map_pin.png');
      final Uint8List imageData = bytes.buffer.asUint8List();

      for (final poi in pois) {
        final point = Point(
          coordinates: Position(
            poi.location.longitude,
            poi.location.latitude,
          ),
        );

        final pointAnnotationOptions = PointAnnotationOptions(
          geometry: point,
          image: imageData,
          iconSize: 0.15,
          textField: poi.name,
          textSize: 12.0,
          textOffset: [0, 1.5],
        );

        await pointAnnotationManager.create(pointAnnotationOptions);
      }

      pointAnnotationManager.addOnPointAnnotationClickListener(
        AnnotationClickListener(
          pointAnnotationManager: pointAnnotationManager,
          onAnnotationTap: onTap,
          mapboxMap: mapboxMap,
        ),
      );

      return pointAnnotationManager;
    } catch (e) {
      throw Exception('Error adding POI annotations: $e');
    }
  }

  Future<void> displayRoute(MapboxMap mapboxMap, Map<String, dynamic> routeGeometry) async {
    try {
      await _clearRoute(mapboxMap);

      final sourceId = 'route-source';
      final layerId = 'route-layer';

      final geoJsonSource = GeoJsonSource(
        id: sourceId,
        data: jsonEncode(routeGeometry),
      );

      await mapboxMap.style.addSource(geoJsonSource);

      final lineLayer = LineLayer(
        id: layerId,
        sourceId: sourceId,
        lineColor: Colors.blue.value,
        lineWidth: 5.0,
        lineOpacity: 0.8,
      );

      await mapboxMap.style.addLayer(lineLayer);
    } catch (e) {
      print('Error displaying route: $e');
    }
  }

  Future<void> clearRoute(MapboxMap mapboxMap) async {
    await _clearRoute(mapboxMap);
  }

  Future<void> _clearRoute(MapboxMap mapboxMap) async {
    try {
      const sourceId = 'route-source';
      const layerId = 'route-layer';

      // if (await _checkIfLayerExists(mapboxMap, layerId)) {
      //   await mapboxMap.style.removeStyleLayer(layerId);
      // }
      //
      // if (await _checkIfSourceExists(mapboxMap, sourceId)) {
      //   await mapboxMap.style.removeStyleSource(sourceId);
      // }
    } catch (e) {
      print('Error clearing route: $e');
    }
  }

  static String getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'historical':
        return "#964B00";
      case 'museum':
        return "#9370DB";
      case 'restaurant':
        return "#FF4500";
      case 'cafe':
        return "#8B4513";
      case 'viewpoint':
        return "#1E90FF";
      default:
        return "#000000";
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
    if (onAnnotationTap != null) {
      onAnnotationTap!(annotation);
    }
    return true;
  }
}