// lib/bloc/poi/poi_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tourist_app/repositories/poi_repository.dart';
import 'poi_event.dart';
import 'poi_state.dart';

@injectable
class POIBloc extends Bloc<POIEvent, POIState> {
  final POIRepository _poiRepository;

  POIBloc(this._poiRepository) : super(POIInitial()) {
    on<LoadPOIs>(_onLoadPOIs);
    on<AddMockPOIs>(_onAddMockPOIs);
  }

  Future<void> _onLoadPOIs(
      LoadPOIs event,
      Emitter<POIState> emit,
      ) async {
    emit(POILoading());

    try {
      final pois = await _poiRepository.getPOIs();
      emit(POIsLoaded(pois: pois));
    } catch (e) {
      emit(POIError(e.toString()));
    }
  }

  Future<void> _onAddMockPOIs(
      AddMockPOIs event,
      Emitter<POIState> emit,
      ) async {
    emit(POILoading());

    try {
      await _poiRepository.addMockPOIs();
      add(LoadPOIs());
    } catch (e) {
      emit(POIError(e.toString()));
    }
  }
}