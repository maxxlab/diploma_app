// lib/screens/map/screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tourist_app/models/poi.dart';
import 'package:tourist_app/models/route_info.dart';
import 'package:tourist_app/screens/map/bloc/map_bloc.dart';
import 'package:tourist_app/screens/map/widgets/directions/directions_toggle_button.dart';
import 'package:tourist_app/screens/map/widgets/directions/route_info_sheet.dart';
import 'package:tourist_app/screens/map/widgets/layer_control_panel.dart';
import 'package:tourist_app/screens/map/widgets/map_appbar.dart';
import 'package:tourist_app/screens/map/widgets/map_controls.dart';
import 'package:tourist_app/screens/map/widgets/poi_sheet.dart';
import 'package:tourist_app/screens/map/directions/bloc/directions_bloc.dart';
import '../../../../core/constants/mapbox_constants.dart';
import '../../../../services/injector/injector.dart';
import '../../../../widgets/error_view.dart';
import '../../../../widgets/laoding_view.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<MapBloc>()),
        BlocProvider(create: (context) => getIt<DirectionsBloc>()),
      ],
      child: const _MapScreenContent(),
    );
  }
}

class _MapScreenContent extends StatelessWidget {
  const _MapScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const MapAppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<MapBloc, MapState>(
            listener: (context, state) {
              if (state is MapReady && state.selectedPOI != null) {
                final directionsState = context.read<DirectionsBloc>().state;

                if (directionsState is DirectionsActive) {
                  context.read<DirectionsBloc>().add(
                    AddWaypoint(poi: state.selectedPOI!),
                  );
                } else {
                  _showPOIDetails(context, state.selectedPOI!);
                }
              }
            },
          ),
          BlocListener<DirectionsBloc, DirectionsState>(
            listener: (context, state) {
              if (state is DirectionsActive && state.routeInfo != null) {
                final mapState = context.read<MapBloc>().state;

                if (mapState is MapReady) {
                  context.read<MapBloc>().add(
                    DisplayRoute(routeGeometry: state.routeInfo!.geometry),
                  );

                  // Debug: Print waypoint IDs and available POI IDs
                  print('Route waypoints: ${state.routeInfo!.waypoints.map((w) => w.poiId).toList()}');
                  print('Available POIs: ${mapState.pois.map((p) => p.id).toList()}');

                  _showRouteInfo(context, state.routeInfo!, mapState.pois);
                }
              } else if (state is DirectionsInitial) {
                context.read<MapBloc>().add(ClearMapRoute());
              } else if (state is DirectionsActive && state.error != null) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Route calculation failed: ${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<MapBloc, MapState>(
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
                  onMapCreated: (mapboxMap) {
                    context.read<MapBloc>().add(InitializeMap(mapboxMap: mapboxMap));
                  },
                ),

                if (state is MapLoading || (state is MapReady && state.isLoading))
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    child: const LoadingView(),
                  ),

                if (state is MapError)
                  ErrorView(
                    message: state.message,
                    onRetry: () {
                      context.read<MapBloc>().add(LoadMapPOIs());
                    },
                  ),

                const MapControls(),
                const LayerControlPanel(),

                BlocBuilder<DirectionsBloc, DirectionsState>(
                  builder: (context, directionsState) {
                    if (directionsState is DirectionsActive) {
                      return Positioned(
                        top: 100,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.directions_walk,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Directions Mode',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              if (directionsState.waypoints.isNotEmpty) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${directionsState.waypoints.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showPOIDetails(BuildContext context, POI poi) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      bounce: true,
      animationCurve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      builder: (context) => Material(
        color: Colors.transparent,
        child: POIDetailsSheet(poi: poi),
      ),
    );
  }

  void _showRouteInfo(BuildContext context, RouteInfo routeInfo, List<POI> pois) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      bounce: true,
      animationCurve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      builder: (context) => Material(
        color: Colors.transparent,
        child: RouteInfoSheet(routeInfo: routeInfo, pois: pois),
      ),
    );
  }
}