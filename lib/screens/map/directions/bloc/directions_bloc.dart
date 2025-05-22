// lib/screens/map/directions/bloc/directions_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../../../models/poi.dart';
import '../../../../models/route_info.dart';
import '../../../../services/directions_service.dart';

@injectable
class DirectionsBloc extends Bloc<DirectionsEvent, DirectionsState> {
  final DirectionsService _directionsService;

  DirectionsBloc(this._directionsService) : super(DirectionsInitial()) {
    on<ToggleDirectionsMode>(_onToggleDirectionsMode);
    on<AddWaypoint>(_onAddWaypoint);
    on<RemoveWaypoint>(_onRemoveWaypoint);
    on<ClearRoute>(_onClearRoute);
    on<CalculateRoute>(_onCalculateRoute);
    on<ReorderWaypoints>(_onReorderWaypoints);
  }

  void _onToggleDirectionsMode(
      ToggleDirectionsMode event,
      Emitter<DirectionsState> emit,
      ) {
    if (state is DirectionsActive) {
      emit(DirectionsInitial());
    } else {
      emit(const DirectionsActive(waypoints: [], routeInfo: null));
    }
  }

  void _onAddWaypoint(
      AddWaypoint event,
      Emitter<DirectionsState> emit,
      ) {
    if (state is DirectionsActive) {
      final currentState = state as DirectionsActive;

      // Check if POI is already in waypoints
      if (currentState.waypoints.any((w) => w.poiId == event.poi.id)) {
        print('POI ${event.poi.id} is already in route');
        return;
      }

      print('Adding waypoint: ${event.poi.id} (${event.poi.name})');

      final waypoints = List<RoutePoint>.from(currentState.waypoints)
        ..add(RoutePoint(
          poiId: event.poi.id,
          latitude: event.poi.location.latitude,
          longitude: event.poi.location.longitude,
        ));

      print('Total waypoints: ${waypoints.length}');
      emit(currentState.copyWith(waypoints: waypoints, routeInfo: null));

      if (waypoints.length >= 2) {
        print('Calculating route for ${waypoints.length} waypoints');
        add(CalculateRoute());
      }
    }
  }

  void _onRemoveWaypoint(
      RemoveWaypoint event,
      Emitter<DirectionsState> emit,
      ) {
    if (state is DirectionsActive) {
      final currentState = state as DirectionsActive;
      final waypoints = currentState.waypoints
          .where((w) => w.poiId != event.poiId)
          .toList();

      emit(currentState.copyWith(waypoints: waypoints, routeInfo: null));

      if (waypoints.length >= 2) {
        add(CalculateRoute());
      }
    }
  }

  void _onClearRoute(
      ClearRoute event,
      Emitter<DirectionsState> emit,
      ) {
    if (state is DirectionsActive) {
      emit(const DirectionsActive(waypoints: [], routeInfo: null));
    }
  }

  Future<void> _onCalculateRoute(
      CalculateRoute event,
      Emitter<DirectionsState> emit,
      ) async {
    if (state is DirectionsActive) {
      final currentState = state as DirectionsActive;

      if (currentState.waypoints.length < 2) {
        print('Not enough waypoints for route calculation: ${currentState.waypoints.length}');
        return;
      }

      print('Starting route calculation for ${currentState.waypoints.length} waypoints');
      emit(currentState.copyWith(isCalculating: true, error: null));

      try {
        final routeInfo = await _directionsService.getWalkingRoute(
          currentState.waypoints,
        );

        print('Route calculated successfully:');
        print('- Total distance: ${routeInfo.totalDistance}m');
        print('- Total duration: ${routeInfo.totalDuration}s');
        print('- Segments: ${routeInfo.segments.length}');

        emit(currentState.copyWith(
          routeInfo: routeInfo,
          isCalculating: false,
          error: null,
        ));
      } catch (e) {
        print('Route calculation failed: $e');
        emit(currentState.copyWith(
          error: e.toString(),
          isCalculating: false,
          routeInfo: null,
        ));
      }
    }
  }

  void _onReorderWaypoints(
      ReorderWaypoints event,
      Emitter<DirectionsState> emit,
      ) {
    if (state is DirectionsActive) {
      final currentState = state as DirectionsActive;
      emit(currentState.copyWith(waypoints: event.waypoints, routeInfo: null));

      if (event.waypoints.length >= 2) {
        add(CalculateRoute());
      }
    }
  }
}

abstract class DirectionsEvent extends Equatable {
  const DirectionsEvent();

  @override
  List<Object?> get props => [];
}

class ToggleDirectionsMode extends DirectionsEvent {}

class AddWaypoint extends DirectionsEvent {
  final POI poi;

  const AddWaypoint({required this.poi});

  @override
  List<Object?> get props => [poi];
}

class RemoveWaypoint extends DirectionsEvent {
  final String poiId;

  const RemoveWaypoint({required this.poiId});

  @override
  List<Object?> get props => [poiId];
}

class ClearRoute extends DirectionsEvent {}

class CalculateRoute extends DirectionsEvent {}

class ReorderWaypoints extends DirectionsEvent {
  final List<RoutePoint> waypoints;

  const ReorderWaypoints({required this.waypoints});

  @override
  List<Object?> get props => [waypoints];
}

abstract class DirectionsState extends Equatable {
  const DirectionsState();

  @override
  List<Object?> get props => [];
}

class DirectionsInitial extends DirectionsState {}

class DirectionsActive extends DirectionsState {
  final List<RoutePoint> waypoints;
  final RouteInfo? routeInfo;
  final bool isCalculating;
  final String? error;

  const DirectionsActive({
    required this.waypoints,
    required this.routeInfo,
    this.isCalculating = false,
    this.error,
  });

  DirectionsActive copyWith({
    List<RoutePoint>? waypoints,
    RouteInfo? routeInfo,
    bool? isCalculating,
    String? error,
  }) {
    return DirectionsActive(
      waypoints: waypoints ?? this.waypoints,
      routeInfo: routeInfo,
      isCalculating: isCalculating ?? this.isCalculating,
      error: error,
    );
  }

  @override
  List<Object?> get props => [waypoints, routeInfo, isCalculating, error];
}