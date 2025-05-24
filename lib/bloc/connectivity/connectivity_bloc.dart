// lib/bloc/connectivity/connectivity_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../services/connectivity_service.dart';

@injectable
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService _connectivityService;
  StreamSubscription<bool>? _connectivitySubscription;

  ConnectivityBloc(this._connectivityService) : super(ConnectivityInitial()) {
    on<ConnectivityStarted>(_onConnectivityStarted);
    on<ConnectivityChanged>(_onConnectivityChanged);
    on<ConnectivityCheckRequested>(_onConnectivityCheckRequested);
  }

  Future<void> _onConnectivityStarted(
      ConnectivityStarted event,
      Emitter<ConnectivityState> emit,
      ) async {
    await _connectivitySubscription?.cancel();

    final isConnected = await _connectivityService.checkConnectivity();
    emit(ConnectivityState(isConnected: isConnected));

    _connectivitySubscription = _connectivityService.connectivityStream.listen(
          (isConnected) => add(ConnectivityChanged(isConnected: isConnected)),
    );
  }

  void _onConnectivityChanged(
      ConnectivityChanged event,
      Emitter<ConnectivityState> emit,
      ) {
    emit(ConnectivityState(isConnected: event.isConnected));
  }

  Future<void> _onConnectivityCheckRequested(
      ConnectivityCheckRequested event,
      Emitter<ConnectivityState> emit,
      ) async {
    final isConnected = await _connectivityService.checkConnectivity();
    emit(ConnectivityState(isConnected: isConnected));
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    _connectivityService.dispose();
    return super.close();
  }
}

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object?> get props => [];
}

class ConnectivityStarted extends ConnectivityEvent {}

class ConnectivityChanged extends ConnectivityEvent {
  final bool isConnected;

  const ConnectivityChanged({required this.isConnected});

  @override
  List<Object?> get props => [isConnected];
}

class ConnectivityCheckRequested extends ConnectivityEvent {}

class ConnectivityInitial extends ConnectivityState {
  ConnectivityInitial() : super(isConnected: true);
}

class ConnectivityState extends Equatable {
  final bool isConnected;

  const ConnectivityState({required this.isConnected});

  bool get isOffline => !isConnected;

  @override
  List<Object?> get props => [isConnected];
}