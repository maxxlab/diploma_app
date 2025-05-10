// lib/screens/map/map_screen.dart
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
    // Load POIs when screen initializes
    context.read<POIBloc>().add(LoadPOIs());
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

    // Enable user location tracking
    _enableLocationComponent();

    // Set up map click handler
    // mapboxMap.onMapTapListener!(_onMapTap);

    // Load POIs onto the map if they're already loaded in the bloc
    final state = context.read<POIBloc>().state;
    if (state is POIsLoaded) {
      _pois = state.pois;
      _addPOIsToMap(_pois);
    }
  }

  // Handle map taps
  void _onMapTap(ScreenCoordinate point) async {
    if (_mapboxMap == null) return;

    try {
      // Create query options
      final options = RenderedQueryOptions(
        layerIds: ["pois-layer"],
        filter: null,
      );

      // Create query geometry
      final geometry = RenderedQueryGeometry.fromScreenCoordinate(point);

      // Query features
      final results =
          await _mapboxMap!.queryRenderedFeatures(geometry, options);

      // Check if any features were found
      if (results.isNotEmpty) {
        final feature = results.first;
        if (feature!.queriedFeature.feature != null) {
          // Parse properties
          final properties =
              jsonDecode(feature.queriedFeature.feature.toString());

          // Get the POI ID
          final poiId = properties['id'] as String?;
          if (poiId != null) {
            // Find the POI in our list
            final poiIndex = _pois.indexWhere((p) => p.id == poiId);
            if (poiIndex >= 0) {
              _showPOIDetails(context, _pois[poiIndex]);
            }
          }
        }
      }
    } catch (e) {
      print('Error querying features: $e');
    }
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

  // Fly to Lviv, Ukraine
  Future<void> _flyToLviv() async {
    if (_mapboxMap == null) return;

    try {
      final cameraOptions = CameraOptions(
        center: Point(
          coordinates: Position(
              24.031111, // Lviv longitude
              49.842957 // Lviv latitude
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
      await MapboxService.addPOIAnnotations(_mapboxMap!, pois,
          (annotation) async {
        // await _handlePinTap(annotation, emit);
      });

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
    // Clean up resources
    if (_mapboxMap != null) {
      // _mapboxMap!.cancelMapClick();
    }
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
              // Mapbox Map Widget
              MapWidget(
                key: const ValueKey('mapWidget'),
                styleUri: MapboxConstants.styleUri,
                cameraOptions: CameraOptions(
                  center: Point(coordinates: Position(24.031111, 49.842957)),
                  // Lviv center
                  zoom: 12.0,
                ),
                onMapCreated: _onMapCreated,
              ),

              // Loading indicator
              if (state is POILoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),

              // Error view
              if (state is POIError)
                ErrorView(
                  message: state.message,
                  onRetry: () {
                    context.read<POIBloc>().add(LoadPOIs());
                  },
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
