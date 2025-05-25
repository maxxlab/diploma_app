// lib/screens/profile/bloc/favorite_poi_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:tourist_app/repositories/favotite_poi_repository.dart';
import '../../../models/favorite_poi.dart';
import '../../../models/poi.dart';

@injectable
class FavoritePOIBloc extends Bloc<FavoritePOIEvent, FavoritePOIState> {
  final FavoritePOIRepository _favoritePOIRepository;

  FavoritePOIBloc(this._favoritePOIRepository) : super(FavoritePOIInitial()) {
    on<LoadFavoritePOIs>(_onLoadFavoritePOIs);
    on<AddFavoritePOI>(_onAddFavoritePOI);
    on<RemoveFavoritePOI>(_onRemoveFavoritePOI);
    on<CheckIsFavorite>(_onCheckIsFavorite);
    on<ToggleFavoritePOI>(_onToggleFavoritePOI);
  }

  Future<void> _onLoadFavoritePOIs(
      LoadFavoritePOIs event,
      Emitter<FavoritePOIState> emit,
      ) async {
    emit(FavoritePOILoading());

    try {
      final favoritePOIs = await _favoritePOIRepository.getFavoritePOIs();
      emit(FavoritePOILoaded(favoritePOIs: favoritePOIs));
    } catch (e) {
      emit(FavoritePOIError(message: e.toString()));
    }
  }

  Future<void> _onAddFavoritePOI(
      AddFavoritePOI event,
      Emitter<FavoritePOIState> emit,
      ) async {
    try {
      await _favoritePOIRepository.addFavoritePOI(event.poi);
      add(LoadFavoritePOIs());
    } catch (e) {
      if (state is FavoritePOILoaded) {
        final currentState = state as FavoritePOILoaded;
        emit(currentState.copyWith(error: e.toString()));
      } else {
        emit(FavoritePOIError(message: e.toString()));
      }
    }
  }

  Future<void> _onRemoveFavoritePOI(
      RemoveFavoritePOI event,
      Emitter<FavoritePOIState> emit,
      ) async {
    try {
      await _favoritePOIRepository.removeFavoritePOI(event.poiId);
      add(LoadFavoritePOIs());
    } catch (e) {
      if (state is FavoritePOILoaded) {
        final currentState = state as FavoritePOILoaded;
        emit(currentState.copyWith(error: e.toString()));
      } else {
        emit(FavoritePOIError(message: e.toString()));
      }
    }
  }

  Future<void> _onCheckIsFavorite(
      CheckIsFavorite event,
      Emitter<FavoritePOIState> emit,
      ) async {
    try {
      final isFavorite = await _favoritePOIRepository.isFavoritePOI(event.poiId);
      emit(FavoritePOIChecked(poiId: event.poiId, isFavorite: isFavorite));
    } catch (e) {
      emit(FavoritePOIError(message: e.toString()));
    }
  }

  Future<void> _onToggleFavoritePOI(
      ToggleFavoritePOI event,
      Emitter<FavoritePOIState> emit,
      ) async {
    try {
      final isFavorite = await _favoritePOIRepository.isFavoritePOI(event.poi.id);

      if (isFavorite) {
        await _favoritePOIRepository.removeFavoritePOI(event.poi.id);
      } else {
        await _favoritePOIRepository.addFavoritePOI(event.poi);
      }

      add(CheckIsFavorite(poiId: event.poi.id));
      add(LoadFavoritePOIs());
    } catch (e) {
      emit(FavoritePOIError(message: e.toString()));
    }
  }
}

abstract class FavoritePOIEvent extends Equatable {
  const FavoritePOIEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoritePOIs extends FavoritePOIEvent {}

class AddFavoritePOI extends FavoritePOIEvent {
  final POI poi;

  const AddFavoritePOI({required this.poi});

  @override
  List<Object?> get props => [poi];
}

class RemoveFavoritePOI extends FavoritePOIEvent {
  final String poiId;

  const RemoveFavoritePOI({required this.poiId});

  @override
  List<Object?> get props => [poiId];
}

class CheckIsFavorite extends FavoritePOIEvent {
  final String poiId;

  const CheckIsFavorite({required this.poiId});

  @override
  List<Object?> get props => [poiId];
}

class ToggleFavoritePOI extends FavoritePOIEvent {
  final POI poi;

  const ToggleFavoritePOI({required this.poi});

  @override
  List<Object?> get props => [poi];
}

abstract class FavoritePOIState extends Equatable {
  const FavoritePOIState();

  @override
  List<Object?> get props => [];
}

class FavoritePOIInitial extends FavoritePOIState {}

class FavoritePOILoading extends FavoritePOIState {}

class FavoritePOILoaded extends FavoritePOIState {
  final List<FavoritePOI> favoritePOIs;
  final String? error;

  const FavoritePOILoaded({
    required this.favoritePOIs,
    this.error,
  });

  FavoritePOILoaded copyWith({
    List<FavoritePOI>? favoritePOIs,
    String? error,
  }) {
    return FavoritePOILoaded(
      favoritePOIs: favoritePOIs ?? this.favoritePOIs,
      error: error,
    );
  }

  @override
  List<Object?> get props => [favoritePOIs, error];
}

class FavoritePOIChecked extends FavoritePOIState {
  final String poiId;
  final bool isFavorite;

  const FavoritePOIChecked({
    required this.poiId,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [poiId, isFavorite];
}

class FavoritePOIError extends FavoritePOIState {
  final String message;

  const FavoritePOIError({required this.message});

  @override
  List<Object?> get props => [message];
}