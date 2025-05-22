// lib/screens/map/widgets/route_info_sheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/core/extensions/context_extension.dart';
import 'package:tourist_app/models/poi.dart';
import 'package:tourist_app/models/route_info.dart';
import 'package:tourist_app/screens/map/directions/bloc/directions_bloc.dart';

class RouteInfoSheet extends StatelessWidget {
  final RouteInfo routeInfo;
  final List<POI> pois;

  const RouteInfoSheet({
    Key? key,
    required this.routeInfo,
    required this.pois,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.directions_walk,
                      color: Colors.blue,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Walking Route',
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<DirectionsBloc>().add(ClearRoute());
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.clear),
                      tooltip: 'Clear Route',
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              _formatDistance(routeInfo.totalDistance),
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Total Distance',
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.grey.shade300,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              _formatDuration(routeInfo.totalDuration),
                              style: context.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Total Time',
                              style: context.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: routeInfo.waypoints.length,
              itemBuilder: (context, index) {
                final waypoint = routeInfo.waypoints[index];
                final poi = pois.firstWhere((p) => p.location.latitude == waypoint.latitude);
                final isLast = index == routeInfo.waypoints.length - 1;
                final segment = isLast ? null : routeInfo.segments[index];

                return _buildWaypointItem(
                  context,
                  poi,
                  segment,
                  index,
                  isLast,
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'CLOSE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaypointItem(
      BuildContext context,
      POI poi,
      RouteSegment? segment,
      int index,
      bool isLast,
      ) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _getCategoryColor(poi.category),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    poi.name,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    poi.category.toUpperCase(),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: _getCategoryColor(poi.category),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<DirectionsBloc>().add(
                  RemoveWaypoint(poiId: poi.id),
                );
              },
              icon: const Icon(Icons.remove_circle_outline),
              color: Colors.red,
              tooltip: 'Remove from route',
            ),
          ],
        ),

        if (!isLast && segment != null) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              const SizedBox(width: 16),
              Container(
                width: 2,
                height: 30,
                color: Colors.grey.shade300,
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.directions_walk,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_formatDistance(segment.distance)} • ${_formatDuration(segment.duration)}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],

        if (!isLast)
          const SizedBox(height: 16),
      ],
    );
  }

  String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.round()}m';
    } else {
      return '${(meters / 1000).toStringAsFixed(1)}km';
    }
  }

  String _formatDuration(double seconds) {
    final minutes = (seconds / 60).round();
    if (minutes < 60) {
      return '${minutes}min';
    } else {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      return '${hours}h ${remainingMinutes}min';
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'historical':
        return const Color(0xFF964B00);
      case 'museum':
        return const Color(0xFF9370DB);
      case 'restaurant':
        return const Color(0xFFFF4500);
      case 'cafe':
        return const Color(0xFF8B4513);
      case 'viewpoint':
        return const Color(0xFF1E90FF);
      default:
        return Colors.teal;
    }
  }
}