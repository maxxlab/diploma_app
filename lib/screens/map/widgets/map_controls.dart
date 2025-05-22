// lib/screens/map/widgets/map_controls.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/screens/map/bloc/map_bloc.dart';
import 'package:tourist_app/screens/map/widgets/directions/directions_toggle_button.dart';

class MapControls extends StatelessWidget {
  const MapControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      right: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DirectionsToggleButton(),
          const SizedBox(height: 16),
          _buildControlButton(
            onPressed: () {
              context.read<MapBloc>().add(
                const FlyToLocation(
                  longitude: 24.031111,
                  latitude: 49.842957,
                ),
              );
            },
            icon: Icons.location_city,
            tooltip: 'Go to Lviv',
          ),
          const SizedBox(height: 16),
          _buildControlButton(
            onPressed: () {
              context.read<MapBloc>().add(
                const ToggleLocationTracking(),
              );
            },
            icon: Icons.my_location,
            tooltip: 'My Location',
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String tooltip,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(28),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
            ),
            child: Tooltip(
              message: tooltip,
              child: Icon(
                icon,
                color: Colors.black87,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}