// lib/screens/map/widgets/events/bloc/events_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../../../../models/event.dart';
import '../../../../../repositories/events_repository.dart';

@injectable
class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventsRepository _eventsRepository;

  EventsBloc(this._eventsRepository) : super(EventsInitial()) {
    on<LoadEvents>(_onLoadEvents);
    on<AddMockEvents>(_onAddMockEvents);
  }

  Future<void> _onLoadEvents(
      LoadEvents event,
      Emitter<EventsState> emit,
      ) async {
    emit(EventsLoading());

    try {
      final events = await _eventsRepository.getEventsByPOI(event.poiId);
      emit(EventsLoaded(events: events));
    } catch (e) {
      emit(EventsError(message: e.toString()));
    }
  }

  Future<void> _onAddMockEvents(
      AddMockEvents event,
      Emitter<EventsState> emit,
      ) async {
    emit(EventsLoading());

    try {
      await _eventsRepository.addMockEvents(event.poiId);
      add(LoadEvents(poiId: event.poiId));
    } catch (e) {
      emit(EventsError(message: e.toString()));
    }
  }
}

abstract class EventsEvent extends Equatable {
  const EventsEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvents extends EventsEvent {
  final String poiId;

  const LoadEvents({required this.poiId});

  @override
  List<Object?> get props => [poiId];
}

class AddMockEvents extends EventsEvent {
  final String poiId;

  const AddMockEvents({required this.poiId});

  @override
  List<Object?> get props => [poiId];
}

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object?> get props => [];
}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final List<Event> events;

  const EventsLoaded({required this.events});

  @override
  List<Object?> get props => [events];
}

class EventsError extends EventsState {
  final String message;

  const EventsError({required this.message});

  @override
  List<Object?> get props => [message];
}