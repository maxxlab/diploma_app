// lib/repositories/events_repository.dart
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

abstract class EventsRepository {
  Future<List<Event>> getEventsByPOI(String poiId);
  Future<void> addEvent(Event event);
  Future<void> addMockEvents(String poiId);
}

@Injectable(as: EventsRepository)
class EventsRepositoryImpl implements EventsRepository {
  final FirebaseFirestore _firestore;

  EventsRepositoryImpl(this._firestore);

  @override
  Future<List<Event>> getEventsByPOI(String poiId) async {
    try {
      final querySnapshot = await _firestore
          .collection('pois')
          .doc(poiId)
          .collection('events')
          .orderBy('startTime', descending: false)
          .get();

      return querySnapshot.docs
          .map((doc) => Event.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get events: ${e.toString()}');
    }
  }

  @override
  Future<void> addEvent(Event event) async {
    try {
      await _firestore
          .collection('pois')
          .doc(event.id.split('_')[0]) // Extract POI ID from event ID
          .collection('events')
          .doc(event.id)
          .set(event.toJson());
    } catch (e) {
      throw Exception('Failed to add event: ${e.toString()}');
    }
  }

  @override
  Future<void> addMockEvents(String poiId) async {
    try {
      final now = DateTime.now();

      final mockEvents = [
        Event(
          id: '${poiId}_concert_2025',
          name: 'Classical Music Concert',
          description: 'An evening of beautiful classical music featuring local artists',
          location: {'type': 'poi', 'poiId': poiId},
          category: 'concert',
          startTime: now.add(const Duration(days: 5, hours: 19)),
          endTime: now.add(const Duration(days: 5, hours: 21, minutes: 30)),
          organizer: 'Lviv Cultural Center',
          priceInfo: 'Adults: ₴150, Students: ₴75',
          photos: [],
          createdAt: now,
          updatedAt: now,
        ),
        Event(
          id: '${poiId}_exhibition_2025',
          name: 'Historical Photography Exhibition',
          description: 'Rare photographs showcasing the rich history of Lviv',
          location: {'type': 'poi', 'poiId': poiId},
          category: 'exhibition',
          startTime: now.add(const Duration(days: 10, hours: 10)),
          endTime: now.add(const Duration(days: 17, hours: 18)),
          organizer: 'Lviv History Museum',
          priceInfo: 'Free admission',
          photos: [],
          createdAt: now,
          updatedAt: now,
        ),
        Event(
          id: '${poiId}_festival_2025',
          name: 'Spring Cultural Festival',
          description: 'Celebrate spring with traditional music, dance, and local cuisine',
          location: {'type': 'poi', 'poiId': poiId},
          category: 'festival',
          startTime: now.add(const Duration(days: 15, hours: 14)),
          endTime: now.add(const Duration(days: 15, hours: 22)),
          organizer: 'Lviv Tourism Board',
          priceInfo: 'Free entry, food and drinks available for purchase',
          photos: [],
          createdAt: now,
          updatedAt: now,
        ),
        Event(
          id: '${poiId}_theater_2025',
          name: 'Ukrainian Drama Performance',
          description: 'A powerful drama showcasing contemporary Ukrainian stories',
          location: {'type': 'poi', 'poiId': poiId},
          category: 'theater',
          startTime: now.add(const Duration(days: 20, hours: 19, minutes: 30)),
          endTime: now.add(const Duration(days: 20, hours: 21, minutes: 45)),
          organizer: 'Lviv Drama Theater',
          priceInfo: 'Tickets from ₴200-₴500',
          photos: [],
          createdAt: now,
          updatedAt: now,
        ),
      ];

      final batch = _firestore.batch();
      for (var event in mockEvents) {
        final docRef = _firestore
            .collection('pois')
            .doc(poiId)
            .collection('events')
            .doc(event.id);
        batch.set(docRef, event.toJson());
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to add mock events: ${e.toString()}');
    }
  }
}