// lib/screens/map/map_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../core/constants/mapbox_constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? _mapboxMap;
  bool _isMapInitialized = false;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isDenied) {
      // Show dialog explaining why location is needed
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Location Permission'),
            content: const Text('This app needs location access to show your position on the map.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  _onMapCreated(MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;
    setState(() {
      _isMapInitialized = true;
    });

    // Enable user location tracking
    _enableLocationComponent();

    // Add a sample point annotation
    _addPointAnnotation();
  }

  Future<void> _enableLocationComponent() async {
    if (_mapboxMap == null) return;

    try {
      await _mapboxMap!.location.updateSettings(
        LocationComponentSettings(
          enabled: true,
          showAccuracyRing: true,
          puckBearingEnabled: true,
        ),
      );
    } catch (e) {
      // Handle location component errors
      print('Error enabling location component: $e');
    }
  }

  Future<void> _addPointAnnotation() async {
    if (_mapboxMap == null) return;

    try {
      // Create point annotation manager
      final pointAnnotationManager = await _mapboxMap!.annotations.createPointAnnotationManager();

      // Create a point annotation
      final point = Point(coordinates: Position(30.5234, 50.4501));
      final pointAnnotationOptions = PointAnnotationOptions(
        geometry: point,
        iconSize: 1.0,
      );

      // Add the annotation
      await pointAnnotationManager.create(pointAnnotationOptions);
    } catch (e) {
      // Handle annotation errors
      print('Error adding annotation: $e');
    }
  }

  // Method to fly to user location
  Future<void> _flyToUserLocation() async {
    if (_mapboxMap == null) return;

    try {
      // Get current location
      if (true) {
        // Create camera options to fly to user location
        final cameraOptions = CameraOptions(
          center: Point(
            coordinates: Position(
                24.031111,
                49.842957
            ),
          ),
          zoom: 14.0,
        );

        await _mapboxMap!.flyTo(cameraOptions, MapAnimationOptions(duration: 2000));
      }
    } catch (e) {
      print('Error flying to user location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            context.go('/login');
          }
        },
        child: Stack(
          children: [
            // MapBox Map Widget
            MapWidget(
              key: const ValueKey('mapWidget'),
              styleUri: MapboxConstants.styleUri,
              cameraOptions: CameraOptions(
                center: Point(coordinates: Position(30.5234, 50.4501)), // Default: Kyiv
                zoom: 12.0,
              ),
              onMapCreated: _onMapCreated,
            ),

            // Bottom controls
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: 'locate',
                    onPressed: _flyToUserLocation,
                    child: const Icon(Icons.my_location),
                  ),
                  FloatingActionButton(
                    heroTag: 'profile',
                    onPressed: () => context.push('/profile'),
                    child: const Icon(Icons.person),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}