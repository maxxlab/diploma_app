// lib/repositories/area_repository.dart
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/area.dart';

abstract class AreaRepository {
  Future<List<Area>> getAreas();
}

@Injectable(as: AreaRepository)
class AreaRepositoryImpl implements AreaRepository {
  final FirebaseFirestore _firestore;

  AreaRepositoryImpl(this._firestore);

  @override
  Future<List<Area>> getAreas() async {
    try {
      final querySnapshot = await _firestore
          .collection('areas')
          .get();

      return querySnapshot.docs
          .map((doc) => Area.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get areas: ${e.toString()}');
    }
  }
}