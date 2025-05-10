// lib/screens/home/map_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tourist_app/screens/home/poi/bloc/poi_bloc.dart';
import 'package:tourist_app/screens/home/poi/bloc/poi_event.dart';
import 'package:tourist_app/screens/home/poi/bloc/poi_state.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../core/constants/mapbox_constants.dart';
import '../../models/poi.dart';
import '../../services/mapbox_service.dart';
import '../../widgets/error_view.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? _mapboxMap;
  bool _isMapInitialized = false;
  List<POI> _pois = [];
  PointAnnotationManager? _pointAnnotationManager;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    context.read<POIBloc>().add(LoadPOIs());
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isDenied) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Location Permission'),
            content: const Text(
                'This app needs location access to show your position on the map.'),
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

    _enableLocationComponent();

    final state = context.read<POIBloc>().state;
    if (state is POIsLoaded) {
      _pois = state.pois;
      _addPOIsToMap(_pois);
    }
  }

  void _handlePointAnnotationTap(PointAnnotation annotation) {
    try {
      final clickedPosition = annotation.geometry.coordinates;

      // Find the POI with matching coordinates
      final matchingPoi = _pois.firstWhere(
              (poi) =>
              _isCoordinateMatch(
                  poi.location.longitude,
                  poi.location.latitude,
                  clickedPosition.lng.toDouble(),
                  clickedPosition.lat.toDouble()
              ),
          orElse: () => throw Exception('No matching POI found')
      );

      _showPOIDetails(context, matchingPoi);
    } catch (e) {
      print('Error handling annotation tap: $e');
    }
  }

  // Helper to check if coordinates match within a small threshold
  bool _isCoordinateMatch(double lon1, double lat1, double lon2, double lat2) {
    const double threshold = 0.0001; // About 11 meters at the equator
    return (lon1 - lon2).abs() < threshold &&
        (lat1 - lat2).abs() < threshold;
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
      print('Error enabling location component: $e');
    }
  }

  Future<void> _flyToLviv() async {
    if (_mapboxMap == null) return;

    try {
      final cameraOptions = CameraOptions(
        center: Point(
          coordinates: Position(
              24.031111,
              49.842957
          ),
        ),
        zoom: 12.0,
      );

      await _mapboxMap!
          .flyTo(cameraOptions, MapAnimationOptions(duration: 2000));
    } catch (e) {
      print('Error flying to Lviv: $e');
    }
  }

  Future<void> _addPOIsToMap(List<POI> pois) async {
    if (_mapboxMap == null || !_isMapInitialized) return;

    _pois = pois;

    try {
      _pointAnnotationManager = await MapboxService.addPOIAnnotations(
          _mapboxMap!,
          pois,
          _handlePointAnnotationTap
      );

      _flyToLviv();
    } catch (e) {
      print('Error adding POIs to map: $e');
    }
  }

  void _showPOIDetails(BuildContext context, POI poi) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              poi.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(poi.description),
            const SizedBox(height: 8),
            Text('Category: ${poi.category}'),
            if (poi.address != null) ...[
              const SizedBox(height: 4),
              Text('Address: ${poi.address}'),
            ],
            if (poi.averageRating > 0) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text('Rating: '),
                  ...List.generate(
                    poi.averageRating.round(),
                        (index) => const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _pointAnnotationManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tourist Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_location),
            onPressed: () {
              context.read<POIBloc>().add(AddMockPOIs());
            },
            tooltip: 'Add Mock POIs',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
      body: BlocConsumer<POIBloc, POIState>(
        listener: (context, state) {
          if (state is POIsLoaded && _isMapInitialized) {
            _addPOIsToMap(state.pois);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              MapWidget(
                key: const ValueKey('mapWidget'),
                styleUri: MapboxConstants.styleUri,
                cameraOptions: CameraOptions(
                  center: Point(coordinates: Position(24.031111, 49.842957)),
                  zoom: 12.0,
                ),
                onMapCreated: _onMapCreated,
              ),

              if (state is POILoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),

              if (state is POIError)
                ErrorView(
                  message: state.message,
                  onRetry: () {
                    context.read<POIBloc>().add(LoadPOIs());
                  },
                ),

              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: 'lviv',
                      onPressed: _flyToLviv,
                      tooltip: 'Go to Lviv',
                      child: const Icon(Icons.location_city),
                    ),
                    FloatingActionButton(
                      heroTag: 'add',
                      onPressed: () {
                        context.read<POIBloc>().add(AddMockPOIs());
                      },
                      tooltip: 'Add POIs',
                      child: const Icon(Icons.add_location),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}