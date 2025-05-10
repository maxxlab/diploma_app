// lib/bloc/poi/poi_state.dart
import 'package:equatable/equatable.dart';
import 'package:tourist_app/models/poi.dart';

abstract class POIState extends Equatable {
  const POIState();

  @override
  List<Object?> get props => [];
}

class POIInitial extends POIState {}

class POILoading extends POIState {}

class POIsLoaded extends POIState {
  final List<POI> pois;

  const POIsLoaded({required this.pois});

  @override
  List<Object?> get props => [pois];
}

class POIError extends POIState {
  final String message;

  const POIError(this.message);

  @override
  List<Object?> get props => [message];
}