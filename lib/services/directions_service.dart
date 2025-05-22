// lib/services/directions_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../core/constants/mapbox_constants.dart';
import '../models/route_info.dart';

@injectable
class DirectionsService {
  static const String _baseUrl = 'https://api.mapbox.com/directions/v5/mapbox';

  Future<RouteInfo> getWalkingRoute(List<RoutePoint> waypoints) async {
    if (waypoints.length < 2) {
      throw Exception('At least 2 waypoints are required');
    }

    final coordinates = waypoints
        .map((point) => '${point.longitude},${point.latitude}')
        .join(';');

    final url = Uri.parse(
      '$_baseUrl/walking/$coordinates'
          '?geometries=geojson'
          '&steps=true'
          '&access_token=${MapboxConstants.accessToken}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return _parseRouteResponse(data, waypoints);
      } else {
        throw Exception('Failed to get route: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  RouteInfo _parseRouteResponse(Map<String, dynamic> data, List<RoutePoint> waypoints) {
    final route = data['routes'][0];
    final geometry = route['geometry'];
    final legs = route['legs'] as List;

    final segments = <RouteSegment>[];

    for (int i = 0; i < legs.length; i++) {
      final leg = legs[i];
      segments.add(RouteSegment(
        fromPoi: waypoints[i].poiId,
        toPoi: waypoints[i + 1].poiId,
        distance: (leg['distance'] as num).toDouble(),
        duration: (leg['duration'] as num).toDouble(),
      ));
    }

    return RouteInfo(
      geometry: geometry,
      segments: segments,
      totalDistance: (route['distance'] as num).toDouble(),
      totalDuration: (route['duration'] as num).toDouble(),
      waypoints: waypoints,
    );
  }
}