// lib/screens/map/widgets/reviews/bloc/reviews_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../models/review.dart';
import '../../../../../repositories/review_repository.dart';

@injectable
class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final ReviewRepository _reviewRepository;
  DocumentSnapshot? _lastDocument;
  bool _hasReachedMax = false;

  ReviewsBloc(this._reviewRepository) : super(ReviewsInitial()) {
    on<LoadReviews>(_onLoadReviews);
    on<LoadMoreReviews>(_onLoadMoreReviews);
    on<AddReview>(_onAddReview);
    on<UpdateReview>(_onUpdateReview);
    on<DeleteReview>(_onDeleteReview);
    on<RefreshReviews>(_onRefreshReviews);
  }

  Future<void> _onLoadReviews(
      LoadReviews event,
      Emitter<ReviewsState> emit,
      ) async {
    emit(ReviewsLoading());
    _lastDocument = null;
    _hasReachedMax = false;

    try {
      final reviews = await _reviewRepository.getReviews(
        event.poiId,
        limit: 5,
      );

      if (reviews.length < 5) {
        _hasReachedMax = true;
      }

      if (reviews.isNotEmpty) {
        _lastDocument = await _getDocumentSnapshot(event.poiId, reviews.last.id);
      }

      emit(ReviewsLoaded(
        reviews: reviews,
        hasReachedMax: _hasReachedMax,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(ReviewsError(message: e.toString()));
    }
  }

  Future<void> _onLoadMoreReviews(
      LoadMoreReviews event,
      Emitter<ReviewsState> emit,
      ) async {
    if (state is! ReviewsLoaded || _hasReachedMax) return;

    final currentState = state as ReviewsLoaded;
    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final moreReviews = await _reviewRepository.getReviews(
        event.poiId,
        limit: 5,
        lastDocument: _lastDocument,
      );

      if (moreReviews.length < 5) {
        _hasReachedMax = true;
      }

      if (moreReviews.isNotEmpty) {
        _lastDocument = await _getDocumentSnapshot(event.poiId, moreReviews.last.id);
      }

      final allReviews = [...currentState.reviews, ...moreReviews];

      emit(ReviewsLoaded(
        reviews: allReviews,
        hasReachedMax: _hasReachedMax,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isLoadingMore: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onAddReview(
      AddReview event,
      Emitter<ReviewsState> emit,
      ) async {
    try {
      await _reviewRepository.addReview(event.review);
      add(RefreshReviews(poiId: event.review.poiId));
    } catch (e) {
      if (state is ReviewsLoaded) {
        final currentState = state as ReviewsLoaded;
        emit(currentState.copyWith(error: e.toString()));
      } else {
        emit(ReviewsError(message: e.toString()));
      }
    }
  }

  Future<void> _onUpdateReview(
      UpdateReview event,
      Emitter<ReviewsState> emit,
      ) async {
    try {
      await _reviewRepository.updateReview(event.review);
      add(RefreshReviews(poiId: event.review.poiId));
    } catch (e) {
      if (state is ReviewsLoaded) {
        final currentState = state as ReviewsLoaded;
        emit(currentState.copyWith(error: e.toString()));
      }
    }
  }

  Future<void> _onDeleteReview(
      DeleteReview event,
      Emitter<ReviewsState> emit,
      ) async {
    try {
      await _reviewRepository.deleteReview(event.poiId, event.reviewId);
      add(RefreshReviews(poiId: event.poiId));
    } catch (e) {
      if (state is ReviewsLoaded) {
        final currentState = state as ReviewsLoaded;
        emit(currentState.copyWith(error: e.toString()));
      }
    }
  }

  Future<void> _onRefreshReviews(
      RefreshReviews event,
      Emitter<ReviewsState> emit,
      ) async {
    _lastDocument = null;
    _hasReachedMax = false;

    try {
      final reviews = await _reviewRepository.getReviews(
        event.poiId,
        limit: 5,
      );

      if (reviews.length < 5) {
        _hasReachedMax = true;
      }

      if (reviews.isNotEmpty) {
        _lastDocument = await _getDocumentSnapshot(event.poiId, reviews.last.id);
      }

      emit(ReviewsLoaded(
        reviews: reviews,
        hasReachedMax: _hasReachedMax,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(ReviewsError(message: e.toString()));
    }
  }

  Future<DocumentSnapshot?> _getDocumentSnapshot(String poiId, String reviewId) async {
    try {
      return await FirebaseFirestore.instance
          .collection('pois')
          .doc(poiId)
          .collection('reviews')
          .doc(reviewId)
          .get();
    } catch (e) {
      return null;
    }
  }
}

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object?> get props => [];
}

class LoadReviews extends ReviewsEvent {
  final String poiId;

  const LoadReviews({required this.poiId});

  @override
  List<Object?> get props => [poiId];
}

class LoadMoreReviews extends ReviewsEvent {
  final String poiId;

  const LoadMoreReviews({required this.poiId});

  @override
  List<Object?> get props => [poiId];
}

class AddReview extends ReviewsEvent {
  final Review review;

  const AddReview({required this.review});

  @override
  List<Object?> get props => [review];
}

class UpdateReview extends ReviewsEvent {
  final Review review;

  const UpdateReview({required this.review});

  @override
  List<Object?> get props => [review];
}

class DeleteReview extends ReviewsEvent {
  final String poiId;
  final String reviewId;

  const DeleteReview({required this.poiId, required this.reviewId});

  @override
  List<Object?> get props => [poiId, reviewId];
}

class RefreshReviews extends ReviewsEvent {
  final String poiId;

  const RefreshReviews({required this.poiId});

  @override
  List<Object?> get props => [poiId];
}

abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object?> get props => [];
}

class ReviewsInitial extends ReviewsState {}

class ReviewsLoading extends ReviewsState {}

class ReviewsLoaded extends ReviewsState {
  final List<Review> reviews;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? error;

  const ReviewsLoaded({
    required this.reviews,
    required this.hasReachedMax,
    required this.isLoadingMore,
    this.error,
  });

  ReviewsLoaded copyWith({
    List<Review>? reviews,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? error,
  }) {
    return ReviewsLoaded(
      reviews: reviews ?? this.reviews,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
    );
  }

  @override
  List<Object?> get props => [reviews, hasReachedMax, isLoadingMore, error];
}

class ReviewsError extends ReviewsState {
  final String message;

  const ReviewsError({required this.message});

  @override
  List<Object?> get props => [message];
}