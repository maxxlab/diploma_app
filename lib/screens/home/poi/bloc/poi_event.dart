// lib/bloc/poi/poi_event.dart
import 'package:equatable/equatable.dart';

abstract class POIEvent extends Equatable {
  const POIEvent();

  @override
  List<Object?> get props => [];
}

class LoadPOIs extends POIEvent {}

class AddMockPOIs extends POIEvent {}