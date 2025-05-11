// lib/features/map/screens/map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:tourist_app/models/poi.dart';
import 'package:tourist_app/screens/map/bloc/map_bloc.dart';
import 'package:tourist_app/screens/map/widgets/map_appbar.dart';
import 'package:tourist_app/screens/map/widgets/map_controls.dart';
import 'package:tourist_app/screens/map/widgets/poi_sheet.dart';
import '../../../../core/constants/mapbox_constants.dart';
import '../../../../services/injector/injector.dart';
import '../../../../widgets/error_view.dart';
import '../../../../widgets/laoding_view.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MapBloc>(),
      child: const _MapScreenContent(),
    );
  }
}

class _MapScreenContent extends StatelessWidget {
  const _MapScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MapAppBar(),
      body: BlocConsumer<MapBloc, MapState>(
        listener: (context, state) {
          if (state is MapReady && state.selectedPOI != null) {
            _showPOIDetails(context, state.selectedPOI!);
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
                onMapCreated: (mapboxMap) {
                  context.read<MapBloc>().add(InitializeMap(mapboxMap: mapboxMap));
                },
              ),

              if (state is MapLoading || (state is MapReady && state.isLoading))
                const LoadingView(),

              if (state is MapError)
                ErrorView(
                  message: state.message,
                  onRetry: () {
                    context.read<MapBloc>().add(LoadMapPOIs());
                  },
                ),

              const MapControls(),
            ],
          );
        },
      ),
    );
  }

  void _showPOIDetails(BuildContext context, POI poi) {
    showModalBottomSheet(
      context: context,
      builder: (context) => POIDetailsSheet(poi: poi),
    );
  }
}
