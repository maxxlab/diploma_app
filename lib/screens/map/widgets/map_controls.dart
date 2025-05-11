import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_app/screens/map/bloc/map_bloc.dart';

class MapControls extends StatelessWidget {
  const MapControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            heroTag: 'lviv',
            onPressed: () {
              context.read<MapBloc>().add(
                const FlyToLocation(
                  longitude: 24.031111,
                  latitude: 49.842957,
                ),
              );
            },
            tooltip: 'Go to Lviv',
            child: const Icon(Icons.location_city),
          ),
          FloatingActionButton(
            heroTag: 'location',
            onPressed: () {
              context.read<MapBloc>().add(
                const ToggleLocationTracking(),
              );
            },
            tooltip: 'My Location',
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}