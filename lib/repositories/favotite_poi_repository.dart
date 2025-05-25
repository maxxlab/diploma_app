// lib/repositories/favorite_poi_repository.dart
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/favorite_poi.dart';
import '../models/poi.dart';

abstract class FavoritePOIRepository {
  Future<List<FavoritePOI>> getFavoritePOIs();
  Future<void> addFavoritePOI(POI poi);
  Future<void> removeFavoritePOI(String poiId);
  Future<bool> isFavoritePOI(String poiId);
}

@Injectable(as: FavoritePOIRepository)
class FavoritePOIRepositoryImpl implements FavoritePOIRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  FavoritePOIRepositoryImpl(this._firestore, this._firebaseAuth);

  @override
  Future<List<FavoritePOI>> getFavoritePOIs() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) return [];

      final querySnapshot = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('favorites')
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => FavoritePOI.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get favorite POIs: ${e.toString()}');
    }
  }

  @override
  Future<void> addFavoritePOI(POI poi) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final favorite = FavoritePOI(
        id: poi.id,
        userId: currentUser.uid,
        poiId: poi.id,
        poiName: poi.name,
        poiDescription: poi.description,
        poiCategory: poi.category,
        poiLatitude: poi.location.latitude,
        poiLongitude: poi.location.longitude,
        poiAddress: poi.address,
        poiRating: poi.averageRating,
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('favorites')
          .doc(poi.id)
          .set(favorite.toJson());
    } catch (e) {
      throw Exception('Failed to add favorite POI: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFavoritePOI(String poiId) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('favorites')
          .doc(poiId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove favorite POI: ${e.toString()}');
    }
  }

  @override
  Future<bool> isFavoritePOI(String poiId) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) return false;

      final doc = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .collection('favorites')
          .doc(poiId)
          .get();

      return doc.exists;
    } catch (e) {
      return false;
    }
  }
}