// lib/screens/map/services/map_service.dart
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/poi.dart';
import '../../../models/area.dart';

@injectable
class MapService {
  final Map<String, List<Area>> _typeGroupedLayers = {};
  int _tapCount = 0;
  Timer? _tapResetTimer;

  Future<void> addSource(
      MapboxMap map, String sourceId, Map<String, dynamic> geoJson) async {
    try {
      bool sourceExists = await _checkIfSourceExists(map, sourceId);

      if (!sourceExists) {
        await map.style.addSource(
          GeoJsonSource(id: sourceId, data: jsonEncode(geoJson)),
        );
        print("Added source: $sourceId");
      } else {
        print("Source already exists: $sourceId");
      }
    } catch (e) {
      print("Error adding source $sourceId: $e");
      rethrow;
    }
  }

  Future<void> addOrUpdateLayer(
      MapboxMap map, Area area, double opacity) async {
    try {
      final layerId = "layer-${area.type}-${area.id}";
      bool layerExists = await _checkIfLayerExists(map, layerId);

      if (!layerExists) {
        // Parse GeoJSON to determine geometry type
        final geoJson = jsonDecode(area.data);
        String geometryType = "";

        // Check if it's a feature collection or a single feature
        if (geoJson['type'] == 'FeatureCollection') {
          // Get the geometry type from the first feature
          if (geoJson['features'] != null && geoJson['features'].isNotEmpty) {
            geometryType = geoJson['features'][0]['geometry']['type'];
          }
        } else if (geoJson['type'] == 'Feature') {
          geometryType = geoJson['geometry']['type'];
        } else {
          geometryType = geoJson['type']; // Assume it's a direct geometry
        }

        switch (geometryType) {
          case 'Point':
            await map.style.addLayer(CircleLayer(
              id: layerId,
              sourceId: area.id,
              circleColor: _getColorForAreaType(area.type).toInt(),
              circleRadius: 5.0,
              circleOpacity: opacity,
              visibility: Visibility.VISIBLE,
            ));
            break;
          case 'LineString':
            await map.style.addLayer(LineLayer(
              id: layerId,
              sourceId: area.id,
              lineColor: _getColorForAreaType(area.type).toInt(),
              lineWidth: 2.0,
              lineOpacity: opacity,
              visibility: Visibility.VISIBLE,
            ));
            break;
          case 'Polygon':
            await map.style.addLayer(FillLayer(
              id: layerId,
              sourceId: area.id,
              fillColor: _getColorForAreaType(area.type).withOpacity(0.5).toInt(),
              fillOutlineColor: _getColorForAreaType(area.type).toInt(),
              fillOpacity: opacity,
              visibility: Visibility.VISIBLE,
            ));
            break;
          default:
            print("Unsupported geometry type: $geometryType");
        }
        print("Added layer: $layerId of type $geometryType");
      } else {
        print("Layer already exists: $layerId");
      }
    } catch (e) {
      print("Error adding layer for area ${area.id}: $e");
      rethrow;
    }
  }

  Future<void> renderAreas(MapboxMap map, List<Area> areas) async {
    const int maxRetries = 3;
    const Duration retryDelay = Duration(milliseconds: 300);

    print("Starting to render ${areas.length} areas");

    // Clear previous layers if we're rendering again
    _typeGroupedLayers.clear();

    for (var area in areas) {
      int retryCount = 0;
      bool success = false;

      while (!success && retryCount < maxRetries) {
        try {
          final geoJson = jsonDecode(area.data);
          await addSource(map, area.id, geoJson);
          await addOrUpdateLayer(map, area, 1.0);

          _typeGroupedLayers.putIfAbsent(area.type, () => []).add(area);
          success = true;
          print("Successfully rendered area: ${area.id}");
        } catch (e) {
          retryCount++;
          print("Attempt $retryCount failed for area ${area.id}: $e");

          if (retryCount < maxRetries) {
            print("Retrying in ${retryDelay.inMilliseconds}ms...");
            await Future.delayed(retryDelay);
          } else {
            print("Failed to render area ${area.id} after $maxRetries attempts");
          }
        }
      }
    }

    // Add a final delay after rendering all layers to ensure they're fully loaded
    await Future.delayed(const Duration(milliseconds: 200));
    print("Area rendering complete. Total type groups: ${_typeGroupedLayers.length}");
  }

  Future<void> toggleLayerVisibility(
      MapboxMap map, String layerId, bool isVisible) async {
    try {
      bool layerExists = await _checkIfLayerExists(map, layerId);
      if (layerExists) {
        await map.style.setStyleLayerProperty(
            layerId, 'visibility', isVisible ? 'visible' : 'none');
      } else {
        print("Layer $layerId not found in map style yet, skipping visibility toggle");
      }
    } catch (e) {
      print("Error toggling layer visibility for $layerId: $e");
    }
  }

  Future<void> toggleLayersByType(
      MapboxMap map, String type, bool isVisible, double opacity) async {
    if (!_typeGroupedLayers.containsKey(type)) return;

    try {
      for (var area in _typeGroupedLayers[type]!) {
        final layerId = "layer-${area.type}-${area.id}";
        await toggleLayerVisibility(map, layerId, isVisible);

        bool layerExists = await _checkIfLayerExists(map, layerId);
        if (layerExists) {
          // Determine the layer type based on the GeoJSON content
          final geoJson = jsonDecode(area.data);
          String geometryType = "";

          if (geoJson['type'] == 'FeatureCollection') {
            if (geoJson['features'] != null && geoJson['features'].isNotEmpty) {
              geometryType = geoJson['features'][0]['geometry']['type'];
            }
          } else if (geoJson['type'] == 'Feature') {
            geometryType = geoJson['geometry']['type'];
          } else {
            geometryType = geoJson['type'];
          }

          switch (geometryType) {
            case 'LineString':
              await map.style.setStyleLayerProperty(layerId, 'line-opacity', opacity);
              break;
            case 'Point':
              await map.style.setStyleLayerProperty(layerId, 'circle-opacity', opacity);
              break;
            case 'Polygon':
              await map.style.setStyleLayerProperty(layerId, 'fill-opacity', opacity);
              break;
          }
        }
      }
    } catch (e) {
      print("Error toggling layers for type $type: $e");
      // Continue execution despite errors
    }
  }

  Future<void> toggleAllTypesVisibility(
      MapboxMap map, bool isVisible, double opacity) async {
    try {
      for (var type in _typeGroupedLayers.keys) {
        await toggleLayersByType(map, type, isVisible, opacity);
      }
    } catch (e) {
      print("Error toggling all types: $e");
    }
  }

  Future<bool> _checkIfLayerExists(MapboxMap map, String layerId) async {
    try {
      var layerIds = await map.style.getStyleLayers();
      return layerIds.any((layer) => layer!.id == layerId);
    } catch (e) {
      print("Error checking if layer exists: $e");
      return false;
    }
  }

  Future<bool> _checkIfSourceExists(MapboxMap map, String sourceId) async {
    try {
      var existingSource = await map.style.getStyleSourceProperties(sourceId);
      return existingSource != null;
    } catch (e) {
      print("Error checking if source exists: $e");
      return false;
    }
  }

  Color _getColorForAreaType(String type) {
    switch (type.toLowerCase()) {
      case 'walking':
        return const Color(0xFF4CAF50); // Green
      case 'cycling':
        return const Color(0xFF2196F3); // Blue
      case 'restricted':
        return const Color(0xFFF44336); // Red
      case 'nature':
        return const Color(0xFF8BC34A); // Light Green
      case 'historical':
        return const Color(0xFFFFC107); // Amber
      default:
        return const Color(0xFF9C27B0); // Purple as default
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

      const sourceId = 'route-source';
      const layerId = 'route-layer';

      final geoJsonSource = GeoJsonSource(
        id: sourceId,
        data: jsonEncode(routeGeometry),
      );

      await mapboxMap.style.addSource(geoJsonSource);

      final lineLayer = LineLayer(
        id: layerId,
        sourceId: sourceId,
        lineColor: const Color(0xFF2196F3).value, // Blue color
        lineWidth: 5.0,
        lineOpacity: 0.8,
      );

      await mapboxMap.style.addLayer(lineLayer);
      print("Route displayed successfully");
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

      if (await _checkIfLayerExists(mapboxMap, layerId)) {
        await mapboxMap.style.removeStyleLayer(layerId);
        print("Route layer removed");
      }

      if (await _checkIfSourceExists(mapboxMap, sourceId)) {
        await mapboxMap.style.removeStyleSource(sourceId);
        print("Route source removed");
      }
    } catch (e) {
      print('Error clearing route: $e');
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

// Extension method to convert Color to int for Mapbox layers
extension ColorExtension on Color {
  int toInt() {
    return value;
  }
}