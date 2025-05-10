// lib/repositories/poi_repository.dart
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tourist_app/core/utils/geojson_converter.dart';
import '../models/poi.dart';
import '../core/constants/firebase_constants.dart';

abstract class POIRepository {
  Future<List<POI>> getPOIs();
  Future<POI> getPOIById(String id);
  Future<void> addPOI(POI poi);
  Future<void> updatePOI(POI poi);
  Future<void> deletePOI(String id);
  Future<void> addMockPOIs(); // For testing purposes
  String getPOIsAsGeoJson(List<POI> pois);
}

@Injectable(as: POIRepository)
class POIRepositoryImpl implements POIRepository {
  final FirebaseFirestore _firestore;

  POIRepositoryImpl(this._firestore);

  @override
  Future<List<POI>> getPOIs() async {
    try {
      final querySnapshot = await _firestore
          .collection('pois')
          .get();

      return querySnapshot.docs
          .map((doc) => POI.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get POIs: ${e.toString()}');
    }
  }

  @override
  Future<POI> getPOIById(String id) async {
    try {
      final docSnapshot = await _firestore
          .collection('pois')
          .doc(id)
          .get();

      if (!docSnapshot.exists) {
        throw Exception('POI not found');
      }

      return POI.fromFirestore(docSnapshot);
    } catch (e) {
      throw Exception('Failed to get POI: ${e.toString()}');
    }
  }

  @override
  Future<void> addPOI(POI poi) async {
    try {
      await _firestore
          .collection('pois')
          .doc(poi.id)
          .set(poi.toJson());
    } catch (e) {
      throw Exception('Failed to add POI: ${e.toString()}');
    }
  }

  @override
  Future<void> updatePOI(POI poi) async {
    try {
      await _firestore
          .collection('pois')
          .doc(poi.id)
          .update(poi.toJson());
    } catch (e) {
      throw Exception('Failed to update POI: ${e.toString()}');
    }
  }

  @override
  Future<void> deletePOI(String id) async {
    try {
      await _firestore
          .collection('pois')
          .doc(id)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete POI: ${e.toString()}');
    }
  }

  @override
  Future<void> addMockPOIs() async {
    // Mock POIs in Lviv
    final mockPOIs = [
      POI(
        id: 'lviv_opera',
        name: 'Lviv Opera',
        description: 'Lviv Opera and Ballet Theater',
        category: 'historical',
        location: GeoPoint(49.8442, 24.0265), // Using Firebase GeoPoint directly
        address: 'Svobody Ave, 28, Lviv',
        contactInfo: {'phone': '+380322356520', 'website': 'https://opera.lviv.ua/'},
        priceCategory: 'moderate',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      POI(
        id: 'rynok_square',
        name: 'Rynok Square',
        description: 'The central square of the city of Lviv',
        category: 'historical',
        location: GeoPoint(49.8417, 24.0318),
        address: 'Rynok Square, Lviv',
        isAccessible: true,
        region: 'Lviv Old Town',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      POI(
        id: 'high_castle',
        name: 'High Castle',
        description: 'Medieval hilltop fortress ruins with panoramic city views',
        category: 'viewpoint',
        location: GeoPoint(49.8477, 24.0393),
        address: 'High Castle Hill, Lviv',
        isAccessible: false,
        region: 'Lviv',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      POI(
        id: 'lychakiv_cemetery',
        name: 'Lychakiv Cemetery',
        description: 'Historic cemetery with beautiful tombstones and sculptures',
        category: 'historical',
        location: GeoPoint(49.8297, 24.0521),
        address: 'Mechnykova St, 33, Lviv',
        contactInfo: {'phone': '+380322756440'},
        priceCategory: 'inexpensive',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      POI(
        id: 'lviv_coffee_mine',
        name: 'Lviv Coffee Mine',
        description: 'Underground coffee museum and cafe',
        category: 'cafe',
        location: GeoPoint(49.8418, 24.0296),
        address: 'Rynok Square, 10, Lviv',
        contactInfo: {'phone': '+380322975489'},
        workingHours: {'mon-sun': '8:00-22:00'},
        priceCategory: 'moderate',
        isAccessible: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    // Add all mock POIs to Firestore
    final batch = _firestore.batch();
    for (var poi in mockPOIs) {
      final docRef = _firestore.collection('pois').doc(poi.id);
      batch.set(docRef, poi.toJson());
    }
    await batch.commit();
  }

  @override
  String getPOIsAsGeoJson(List<POI> pois) {
    return GeoJsonConverter.poisToFeatureCollection(pois);
  }
}