// lib/services/caching_service.dart
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/poi.dart';
import '../models/area.dart';
import '../models/event.dart';

@injectable
class CachingService {
  static const String _poisKey = 'cached_pois';
  static const String _areasKey = 'cached_areas';
  static const String _eventsKey = 'cached_events';
  static const String _lastSyncKey = 'last_sync_timestamp';

  Future<void> cachePOIs(List<POI> pois) async {
    final prefs = await SharedPreferences.getInstance();
    final poisJson = pois.map((poi) => poi.toJson()).toList();
    await prefs.setString(_poisKey, jsonEncode(poisJson));
    await _updateLastSyncTime();
  }

  Future<List<POI>> getCachedPOIs() async {
    final prefs = await SharedPreferences.getInstance();
    final poisString = prefs.getString(_poisKey);

    if (poisString == null) return [];

    try {
      final List<dynamic> poisJson = jsonDecode(poisString);
      return poisJson
          .map((json) => POI.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> cacheAreas(List<Area> areas) async {
    final prefs = await SharedPreferences.getInstance();
    final areasJson = areas.map((area) => area.toJson()).toList();
    await prefs.setString(_areasKey, jsonEncode(areasJson));
    await _updateLastSyncTime();
  }

  Future<List<Area>> getCachedAreas() async {
    final prefs = await SharedPreferences.getInstance();
    final areasString = prefs.getString(_areasKey);

    if (areasString == null) return [];

    try {
      final List<dynamic> areasJson = jsonDecode(areasString);
      return areasJson
          .map((json) => Area.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> cacheEvents(String poiId, List<Event> events) async {
    final prefs = await SharedPreferences.getInstance();
    final eventsString = prefs.getString(_eventsKey) ?? '{}';

    try {
      final Map<String, dynamic> allEvents = jsonDecode(eventsString);
      final eventsJson = events.map((event) => event.toJson()).toList();
      allEvents[poiId] = eventsJson;

      await prefs.setString(_eventsKey, jsonEncode(allEvents));
      await _updateLastSyncTime();
    } catch (e) {
      final Map<String, dynamic> allEvents = {};
      final eventsJson = events.map((event) => event.toJson()).toList();
      allEvents[poiId] = eventsJson;

      await prefs.setString(_eventsKey, jsonEncode(allEvents));
    }
  }

  Future<List<Event>> getCachedEvents(String poiId) async {
    final prefs = await SharedPreferences.getInstance();
    final eventsString = prefs.getString(_eventsKey);

    if (eventsString == null) return [];

    try {
      final Map<String, dynamic> allEvents = jsonDecode(eventsString);
      final List<dynamic>? eventsJson = allEvents[poiId];

      if (eventsJson == null) return [];

      return eventsJson
          .map((json) => Event.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<DateTime?> getLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_lastSyncKey);

    if (timestamp == null) return null;

    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  Future<void> _updateLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastSyncKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<bool> hasOfflineData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_poisKey) || prefs.containsKey(_areasKey);
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_poisKey);
    await prefs.remove(_areasKey);
    await prefs.remove(_eventsKey);
    await prefs.remove(_lastSyncKey);
  }
}