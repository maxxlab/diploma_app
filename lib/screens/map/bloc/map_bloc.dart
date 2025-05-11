// lib/features/map/blocs/map_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:tourist_app/screens/map/services/map_service.dart';
import '../../../models/poi.dart';
import '../../../repositories/poi_repository.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final POIRepository _poiRepository;
  final MapService _mapService;
  PointAnnotationManager? _pointAnnotationManager;

  MapBloc(this._poiRepository, this._mapService) : super(MapInitial()) {
    on<InitializeMap>(_onInitializeMap);
    on<LoadMapPOIs>(_onLoadMapPOIs);
    on<SelectPOI>(_onSelectPOI);
    on<FlyToLocation>(_onFlyToLocation);
    on<ToggleLocationTracking>(_onToggleLocationTracking);
    on<HandlePOITap>(_onHandlePOITap);
    on<AddMockPOIsRequested>(_onAddMockPOIs);
  }

  Future<void> _onInitializeMap(
      InitializeMap event,
      Emitter<MapState> emit,
      ) async {
    emit(MapLoading());
    try {
      await _mapService.enableLocationComponent(event.mapboxMap);
      emit(MapReady(mapboxMap: event.mapboxMap));
      add(LoadMapPOIs());
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  Future<void> _onLoadMapPOIs(
      LoadMapPOIs event,
      Emitter<MapState> emit,
      ) async {
    if (state is! MapReady) {
      emit(MapError(message: 'Map is not ready yet'));
      return;
    }

    final currentState = state as MapReady;
    emit(currentState.copyWith(isLoading: true));

    try {
      final pois = await _poiRepository.getPOIs();

      if (currentState.mapboxMap != null) {
        _pointAnnotationManager = await _mapService.addPOIAnnotations(
          currentState.mapboxMap!,
          pois,
              (annotation) {
            add(HandlePOITap(annotation: annotation, pois: pois));
          },
        );

        // Fly to Lviv after loading POIs
        await _mapService.flyToLocation(
          currentState.mapboxMap!,
          24.031111,
          49.842957,
          12.0,
        );
      }

      emit(currentState.copyWith(pois: pois, isLoading: false));
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  void _onSelectPOI(
      SelectPOI event,
      Emitter<MapState> emit,
      ) {
    if (state is! MapReady) return;

    final currentState = state as MapReady;
    emit(currentState.copyWith(selectedPOI: event.poi));
  }

  Future<void> _onFlyToLocation(
      FlyToLocation event,
      Emitter<MapState> emit,
      ) async {
    if (state is! MapReady || (state as MapReady).mapboxMap == null) return;

    try {
      await _mapService.flyToLocation(
        (state as MapReady).mapboxMap!,
        event.longitude,
        event.latitude,
        event.zoom,
      );
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  Future<void> _onToggleLocationTracking(
      ToggleLocationTracking event,
      Emitter<MapState> emit,
      ) async {
    if (state is! MapReady || (state as MapReady).mapboxMap == null) return;

    try {
      await _mapService.enableLocationComponent((state as MapReady).mapboxMap!);
      emit((state as MapReady).copyWith(isLocationTrackingEnabled: event.enabled));
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  void _onHandlePOITap(
      HandlePOITap event,
      Emitter<MapState> emit,
      ) {
    if (state is! MapReady) return;

    try {
      final clickedPosition = event.annotation.geometry.coordinates;

      // Find the POI with matching coordinates
      final matchingPoi = event.pois.firstWhere(
            (poi) => _isCoordinateMatch(
          poi.location.longitude,
          poi.location.latitude,
          clickedPosition.lng.toDouble(),
          clickedPosition.lat.toDouble(),
        ),
        orElse: () => throw Exception('No matching POI found'),
      );

      add(SelectPOI(poi: matchingPoi));
    } catch (e) {
      // Just log the error but don't change state - this avoids disrupting the UI
      print('Error handling annotation tap: $e');
    }
  }

  Future<void> _onAddMockPOIs(
      AddMockPOIsRequested event,
      Emitter<MapState> emit,
      ) async {
    if (state is! MapReady) return;

    final currentState = state as MapReady;
    emit(currentState.copyWith(isLoading: true));

    try {
      await _poiRepository.addMockPOIs();
      add(LoadMapPOIs());
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  // Helper to check if coordinates match within a small threshold
  bool _isCoordinateMatch(double lon1, double lat1, double lon2, double lat2) {
    const double threshold = 0.0001; // About 11 meters at the equator
    return (lon1 - lon2).abs() < threshold &&
        (lat1 - lat2).abs() < threshold;
  }
}

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

class InitializeMap extends MapEvent {
  final MapboxMap mapboxMap;

  const InitializeMap({required this.mapboxMap});

  @override
  List<Object?> get props => [mapboxMap];
}

class LoadMapPOIs extends MapEvent {}

class SelectPOI extends MapEvent {
  final POI poi;

  const SelectPOI({required this.poi});

  @override
  List<Object?> get props => [poi];
}

class FlyToLocation extends MapEvent {
  final double longitude;
  final double latitude;
  final double zoom;

  const FlyToLocation({
    required this.longitude,
    required this.latitude,
    this.zoom = 12.0,
  });

  @override
  List<Object?> get props => [longitude, latitude, zoom];
}

class ToggleLocationTracking extends MapEvent {
  final bool enabled;

  const ToggleLocationTracking({this.enabled = true});

  @override
  List<Object?> get props => [enabled];
}

class HandlePOITap extends MapEvent {
  final PointAnnotation annotation;
  final List<POI> pois;

  const HandlePOITap({
    required this.annotation,
    required this.pois,
  });

  @override
  List<Object?> get props => [annotation, pois];
}

class AddMockPOIsRequested extends MapEvent {}

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapReady extends MapState {
  final MapboxMap? mapboxMap;
  final List<POI> pois;
  final POI? selectedPOI;
  final bool isLocationTrackingEnabled;
  final bool isLoading;

  const MapReady({
    this.mapboxMap,
    this.pois = const [],
    this.selectedPOI,
    this.isLocationTrackingEnabled = false,
    this.isLoading = false,
  });

  MapReady copyWith({
    MapboxMap? mapboxMap,
    List<POI>? pois,
    POI? selectedPOI,
    bool? isLocationTrackingEnabled,
    bool? isLoading,
  }) {
    return MapReady(
      mapboxMap: mapboxMap ?? this.mapboxMap,
      pois: pois ?? this.pois,
      selectedPOI: selectedPOI,
      isLocationTrackingEnabled: isLocationTrackingEnabled ?? this.isLocationTrackingEnabled,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    mapboxMap,
    pois,
    selectedPOI,
    isLocationTrackingEnabled,
    isLoading,
  ];
}

class MapError extends MapState {
  final String message;

  const MapError({required this.message});

  @override
  List<Object?> get props => [message];
}