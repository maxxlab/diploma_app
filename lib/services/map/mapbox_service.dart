// lib/services/mapbox/mapbox_service.dart

import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:tourist_app/core/utils/app_logger.dart';
import 'dart:async';
import 'dart:convert';

class MapboxDirectionsResponse {
  final List<List<double>> geometry;
  final double duration;
  final double distance;
  final String error;

  MapboxDirectionsResponse({
    required this.geometry,
    required this.duration,
    required this.distance,
    this.error = '',
  });

  factory MapboxDirectionsResponse.fromJson(Map<String, dynamic> json) {
    try {
      final routes = json['routes'] as List;
      if (routes.isEmpty) {
        return MapboxDirectionsResponse(
          geometry: [],
          duration: 0,
          distance: 0,
          error: 'No routes found',
        );
      }

      final route = routes.first as Map<String, dynamic>;
      final geometry = _decodePolyline(route['geometry'] as String);
      final duration = (route['duration'] as num).toDouble();
      final distance = (route['distance'] as num).toDouble();

      return MapboxDirectionsResponse(
        geometry: geometry,
        duration: duration,
        distance: distance,
      );
    } catch (e) {
      return MapboxDirectionsResponse(
        geometry: [],
        duration: 0,
        distance: 0,
        error: e.toString(),
      );
    }
  }

  factory MapboxDirectionsResponse.error(String errorMessage) {
    return MapboxDirectionsResponse(
      geometry: [],
      duration: 0,
      distance: 0,
      error: errorMessage,
    );
  }

  static List<List<double>> _decodePolyline(String encoded) {
    List<List<double>> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add([lat / 1E5, lng / 1E5]);
    }
    return points;
  }
}

enum MapboxNavigationMode {
  driving,
  walking,
  cycling,
}

extension MapboxNavigationModeExtension on MapboxNavigationMode {
  String get value {
    switch (this) {
      case MapboxNavigationMode.driving:
        return 'driving';
      case MapboxNavigationMode.walking:
        return 'walking';
      case MapboxNavigationMode.cycling:
        return 'cycling';
    }
  }
}

abstract class MapboxService {
  Future<MapboxDirectionsResponse> getDirections({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
    MapboxNavigationMode mode = MapboxNavigationMode.walking,
    List<List<double>>? waypoints,
  });

  Future<String> getStaticMapImageUrl({
    required double centerLat,
    required double centerLng,
    required int zoomLevel,
    required int width,
    required int height,
    List<Map<String, dynamic>>? markers,
    String? polyline,
  });

  Future<Map<String, dynamic>> geocode(String query);

  Future<Map<String, dynamic>> reverseGeocode({
    required double latitude,
    required double longitude,
  });
}

@Injectable(as: MapboxService)
class MapboxServiceImpl implements MapboxService {
  final Dio _dio;
  final String _accessToken;
  final String _baseUrl;

  MapboxServiceImpl(
      this._dio,
      ) : _accessToken = 'YOUR_MAPBOX_ACCESS_TOKEN', // Replace with your actual token
        _baseUrl = 'https://api.mapbox.com';

  @override
  Future<MapboxDirectionsResponse> getDirections({
    required double startLat,
    required double startLng,
    required double endLat,
    required double endLng,
    MapboxNavigationMode mode = MapboxNavigationMode.walking,
    List<List<double>>? waypoints,
  }) async {
    try {
      // Build the coordinates string
      final coordinates = '$startLng,$startLat;$endLng,$endLat';

      // Add waypoints if provided
      String waypointsParam = '';
      if (waypoints != null && waypoints.isNotEmpty) {
        final waypointsList = waypoints.map((wp) => '${wp[1]},${wp[0]}').join(';');
        waypointsParam = '$startLng,$startLat;$waypointsList;$endLng,$endLat';
      }

      final url = '$_baseUrl/directions/v5/mapbox/${mode.value}/${waypointsParam.isNotEmpty ? waypointsParam : coordinates}';

      final response = await _dio.get(
        url,
        queryParameters: {
          'access_token': _accessToken,
          'geometries': 'polyline',
          'overview': 'full',
          'steps': 'true',
        },
      );

      if (response.statusCode == 200) {
        return MapboxDirectionsResponse.fromJson(response.data);
      } else {
        AppLogger.error('Error getting directions: ${response.statusCode}');
        return MapboxDirectionsResponse.error(
          'Error getting directions: ${response.statusCode}',
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error getting directions', e, stackTrace);
      return MapboxDirectionsResponse.error('Error getting directions: $e');
    }
  }

  @override
  Future<String> getStaticMapImageUrl({
    required double centerLat,
    required double centerLng,
    required int zoomLevel,
    required int width,
    required int height,
    List<Map<String, dynamic>>? markers,
    String? polyline,
  }) async {
    try {
      // Base URL for static map
      final baseUrl = '$_baseUrl/styles/v1/mapbox/streets-v11/static';

      // Add markers if provided
      String markersParam = '';
      if (markers != null && markers.isNotEmpty) {
        final markersList = markers.map((marker) {
          final lat = marker['lat'];
          final lng = marker['lng'];
          final color = marker['color'] ?? 'red';
          final size = marker['size'] ?? 'medium';
          return 'pin-$size-$color($lng,$lat)';
        }).join(',');

        markersParam = '$markersList,';
      }

      // Add polyline if provided
      String polylineParam = '';
      if (polyline != null && polyline.isNotEmpty) {
        final color = 'blue';
        final weight = '5';
        polylineParam = 'path-$weight+$color($polyline),';
      }

      // Construct the final URL
      final url = '$baseUrl/$polylineParam$markersParam$centerLng,$centerLat,$zoomLevel/$width x$height';

      // Add access token
      return '$url?access_token=$_accessToken';
    } catch (e, stackTrace) {
      AppLogger.error('Error generating static map URL', e, stackTrace);
      throw Exception('Failed to generate static map URL: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> geocode(String query) async {
    try {
      final url = '$_baseUrl/geocoding/v5/mapbox.places/$query.json';

      final response = await _dio.get(
        url,
        queryParameters: {
          'access_token': _accessToken,
          'limit': 5,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        AppLogger.error('Error geocoding: ${response.statusCode}');
        throw Exception('Error geocoding: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error geocoding', e, stackTrace);
      throw Exception('Failed to geocode address: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final url = '$_baseUrl/geocoding/v5/mapbox.places/$longitude,$latitude.json';

      final response = await _dio.get(
        url,
        queryParameters: {
          'access_token': _accessToken,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        AppLogger.error('Error reverse geocoding: ${response.statusCode}');
        throw Exception('Error reverse geocoding: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error reverse geocoding', e, stackTrace);
      throw Exception('Failed to reverse geocode coordinates: $e');
    }
  }
}