// lib/repositories/review_repository.dart
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review.dart';

abstract class ReviewRepository {
  Future<List<Review>> getReviews(String poiId, {int limit = 5, DocumentSnapshot? lastDocument});
  Future<Review> addReview(Review review);
  Future<void> updateReview(Review review);
  Future<void> deleteReview(String poiId, String reviewId);
  Future<double> calculateAverageRating(String poiId);
}

@Injectable(as: ReviewRepository)
class ReviewRepositoryImpl implements ReviewRepository {
  final FirebaseFirestore _firestore;

  ReviewRepositoryImpl(this._firestore);

  @override
  Future<List<Review>> getReviews(String poiId, {int limit = 5, DocumentSnapshot? lastDocument}) async {
    try {
      Query query = _firestore
          .collection('pois')
          .doc(poiId)
          .collection('reviews')
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final querySnapshot = await query.get();

      return querySnapshot.docs
          .map((doc) => Review.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get reviews: ${e.toString()}');
    }
  }

  @override
  Future<Review> addReview(Review review) async {
    try {
      final docRef = _firestore
          .collection('pois')
          .doc(review.poiId)
          .collection('reviews')
          .doc();

      final reviewWithId = review.copyWith(
        id: docRef.id,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await docRef.set(reviewWithId.toJson());

      await _updatePoiAverageRating(review.poiId);

      return reviewWithId;
    } catch (e) {
      throw Exception('Failed to add review: ${e.toString()}');
    }
  }

  @override
  Future<void> updateReview(Review review) async {
    try {
      final updatedReview = review.copyWith(updatedAt: DateTime.now());

      await _firestore
          .collection('pois')
          .doc(review.poiId)
          .collection('reviews')
          .doc(review.id)
          .update(updatedReview.toJson());

      await _updatePoiAverageRating(review.poiId);
    } catch (e) {
      throw Exception('Failed to update review: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteReview(String poiId, String reviewId) async {
    try {
      await _firestore
          .collection('pois')
          .doc(poiId)
          .collection('reviews')
          .doc(reviewId)
          .delete();

      await _updatePoiAverageRating(poiId);
    } catch (e) {
      throw Exception('Failed to delete review: ${e.toString()}');
    }
  }

  @override
  Future<double> calculateAverageRating(String poiId) async {
    try {
      final querySnapshot = await _firestore
          .collection('pois')
          .doc(poiId)
          .collection('reviews')
          .get();

      if (querySnapshot.docs.isEmpty) {
        return 0.0;
      }

      double totalRating = 0.0;
      for (var doc in querySnapshot.docs) {
        final review = Review.fromFirestore(doc);
        totalRating += review.rating;
      }

      return totalRating / querySnapshot.docs.length;
    } catch (e) {
      throw Exception('Failed to calculate average rating: ${e.toString()}');
    }
  }

  Future<void> _updatePoiAverageRating(String poiId) async {
    try {
      final averageRating = await calculateAverageRating(poiId);

      await _firestore
          .collection('pois')
          .doc(poiId)
          .update({'averageRating': averageRating});
    } catch (e) {
      print('Failed to update POI average rating: $e');
    }
  }
}