// lib/features/map/blocs/map_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:tourist_app/models/area.dart';
import 'package:tourist_app/repositories/area_repository.dart';
import 'package:tourist_app/screens/map/services/map_service.dart';
import '../../../models/poi.dart';
import '../../../models/route_info.dart';
import '../../../repositories/poi_repository.dart';
import '../directions/bloc/directions_bloc.dart';

@injectable
class MapBloc extends Bloc<MapEvent, MapState> {
  final POIRepository _poiRepository;
  final AreaRepository _areaRepository;
  final MapService _mapService;
  PointAnnotationManager? _pointAnnotationManager;

  MapBloc(this._poiRepository, this._areaRepository, this._mapService) : super(MapInitial()) {
    on<InitializeMap>(_onInitializeMap);
    on<LoadMapPOIs>(_onLoadMapPOIs);
    on<LoadMapAreas>(_onLoadMapAreas);
    on<SelectPOI>(_onSelectPOI);
    on<FlyToLocation>(_onFlyToLocation);
    on<ToggleLocationTracking>(_onToggleLocationTracking);
    on<HandlePOITap>(_onHandlePOITap);
    on<AddMockPOIsRequested>(_onAddMockPOIs);
    on<ToggleAreaVisibility>(_onToggleAreaVisibility);
    on<DisplayRoute>(_onDisplayRoute);
    on<ClearMapRoute>(_onClearMapRoute);
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
      add(LoadMapAreas());
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  Future<void> _onLoadMapAreas(
      LoadMapAreas event,
      Emitter<MapState> emit,
      ) async {
    if (state is! MapReady) {
      emit(MapError(message: 'Map is not ready yet'));
      return;
    }

    final currentState = state as MapReady;
    emit(currentState.copyWith(isLoading: true));

    try {
      final areas = await _areaRepository.getAreas();

      if (currentState.mapboxMap != null) {
        await _mapService.renderAreas(
          currentState.mapboxMap!,
          areas,
        );

        final visibleAreaTypes = areas.map((area) => area.type).toSet();

        emit(currentState.copyWith(
          areas: areas,
          visibleAreaTypes: visibleAreaTypes,
          isLoading: false,
        ));
      } else {
        emit(currentState.copyWith(
          areas: areas,
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  Future<void> _onToggleAreaVisibility(
      ToggleAreaVisibility event,
      Emitter<MapState> emit,
      ) async {
    if (state is! MapReady || (state as MapReady).mapboxMap == null) return;

    final currentState = state as MapReady;
    final mapboxMap = currentState.mapboxMap!;

    try {
      final newVisibleAreaTypes = Set<String>.from(currentState.visibleAreaTypes);

      if (event.visible) {
        newVisibleAreaTypes.add(event.areaType);
      } else {
        newVisibleAreaTypes.remove(event.areaType);
      }

      await _mapService.toggleLayersByType(
        mapboxMap,
        event.areaType,
        event.visible,
        event.visible ? 1.0 : 0.0,
      );

      emit(currentState.copyWith(visibleAreaTypes: newVisibleAreaTypes));
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

  Future<void> _onDisplayRoute(
      DisplayRoute event,
      Emitter<MapState> emit,
      ) async {
    if (state is! MapReady || (state as MapReady).mapboxMap == null) return;

    try {
      await _mapService.displayRoute(
        (state as MapReady).mapboxMap!,
        event.routeGeometry,
      );
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  Future<void> _onClearMapRoute(
      ClearMapRoute event,
      Emitter<MapState> emit,
      ) async {
    if (state is! MapReady || (state as MapReady).mapboxMap == null) return;

    try {
      await _mapService.clearRoute((state as MapReady).mapboxMap!);
    } catch (e) {
      emit(MapError(message: e.toString()));
    }
  }

  bool _isCoordinateMatch(double lon1, double lat1, double lon2, double lat2) {
    const double threshold = 0.0001;
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

class LoadMapAreas extends MapEvent {}

class ToggleAreaVisibility extends MapEvent {
  final String areaType;
  final bool visible;

  const ToggleAreaVisibility({
    required this.areaType,
    required this.visible,
  });

  @override
  List<Object?> get props => [areaType, visible];
}

class DisplayRoute extends MapEvent {
  final Map<String, dynamic> routeGeometry;

  const DisplayRoute({required this.routeGeometry});

  @override
  List<Object?> get props => [routeGeometry];
}

class ClearMapRoute extends MapEvent {}

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
  final List<Area> areas;
  final Set<String> visibleAreaTypes;

  const MapReady({
    this.mapboxMap,
    this.pois = const [],
    this.selectedPOI,
    this.isLocationTrackingEnabled = false,
    this.isLoading = false,
    this.areas = const [],
    this.visibleAreaTypes = const {},
  });

  MapReady copyWith({
    MapboxMap? mapboxMap,
    List<POI>? pois,
    POI? selectedPOI,
    bool? isLocationTrackingEnabled,
    bool? isLoading,
    List<Area>? areas,
    Set<String>? visibleAreaTypes,
  }) {
    return MapReady(
      mapboxMap: mapboxMap ?? this.mapboxMap,
      pois: pois ?? this.pois,
      selectedPOI: selectedPOI,
      isLocationTrackingEnabled: isLocationTrackingEnabled ?? this.isLocationTrackingEnabled,
      isLoading: isLoading ?? this.isLoading,
      areas: areas ?? this.areas,
      visibleAreaTypes: visibleAreaTypes ?? this.visibleAreaTypes,
    );
  }

  @override
  List<Object?> get props => [
    mapboxMap,
    pois,
    selectedPOI,
    isLocationTrackingEnabled,
    isLoading,
    areas,
    visibleAreaTypes,
  ];
}

class MapError extends MapState {
  final String message;

  const MapError({required this.message});

  @override
  List<Object?> get props => [message];
}