// lib/screens/map/directions/bloc/directions_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../../../models/poi.dart';
import '../../../../models/route_info.dart';
import '../../../../services/directions_service.dart';
import '../../../../services/connectivity_service.dart';

@injectable
class DirectionsBloc extends Bloc<DirectionsEvent, DirectionsState> {
  final DirectionsService _directionsService;
  final ConnectivityService _connectivityService;

  DirectionsBloc(this._directionsService, this._connectivityService)
      : super(DirectionsInitial()) {
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
    if (!_connectivityService.isConnected) {
      return;
    }

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
    if (!_connectivityService.isConnected) {
      return;
    }

    if (state is DirectionsActive) {
      final currentState = state as DirectionsActive;

      if (currentState.waypoints.any((w) => w.poiId == event.poi.id)) {
        return;
      }

      final waypoints = List<RoutePoint>.from(currentState.waypoints)
        ..add(RoutePoint(
          poiId: event.poi.id,
          latitude: event.poi.location.latitude,
          longitude: event.poi.location.longitude,
        ));

      emit(currentState.copyWith(waypoints: waypoints, routeInfo: null));

      if (waypoints.length >= 2) {
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

      if (waypoints.length >= 2 && _connectivityService.isConnected) {
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
    if (!_connectivityService.isConnected) {
      if (state is DirectionsActive) {
        final currentState = state as DirectionsActive;
        emit(currentState.copyWith(
          error: 'Directions are not available in offline mode',
          isCalculating: false,
          routeInfo: null,
        ));
      }
      return;
    }

    if (state is DirectionsActive) {
      final currentState = state as DirectionsActive;

      if (currentState.waypoints.length < 2) {
        return;
      }

      emit(currentState.copyWith(isCalculating: true, error: null));

      try {
        final routeInfo = await _directionsService.getWalkingRoute(
          currentState.waypoints,
        );

        emit(currentState.copyWith(
          routeInfo: routeInfo,
          isCalculating: false,
          error: null,
        ));
      } catch (e) {
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
    if (!_connectivityService.isConnected) {
      return;
    }

    if (state is DirectionsActive) {
      final currentState = state as DirectionsActive;
      emit(currentState.copyWith(waypoints: event.waypoints, routeInfo: null));

      if (event.waypoints.length >= 2) {
        add(CalculateRoute());
      }
    }
  }
}

// Keep all the existing Events and States from your original file
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