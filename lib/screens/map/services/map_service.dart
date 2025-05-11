// lib/features/map/services/map_service.dart
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../models/poi.dart';

@injectable
class MapService {
  Future<void> flyToLocation(
      MapboxMap mapboxMap,
      double longitude,
      double latitude,
      double zoom,
      ) async {
    try {
      final cameraOptions = CameraOptions(
        center: Point(
          coordinates: Position(
            longitude,
            latitude,
          ),
        ),
        zoom: zoom,
      );

      await mapboxMap.flyTo(cameraOptions, MapAnimationOptions(duration: 2000));
    } catch (e) {
      throw Exception('Error flying to location: $e');
    }
  }

  Future<void> enableLocationComponent(MapboxMap mapboxMap) async {
    try {
      await mapboxMap.location.updateSettings(
        LocationComponentSettings(
          enabled: true,
          showAccuracyRing: true,
          puckBearingEnabled: true,
        ),
      );
    } catch (e) {
      throw Exception('Error enabling location component: $e');
    }
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
          iconSize: 0.15,
          image: imageData,
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

  String getCategoryColor(String category) {
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