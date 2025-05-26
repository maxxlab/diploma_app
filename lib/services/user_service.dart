// lib/services/user_service.dart
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants/firebase_constants.dart';

@injectable
class UserService {
  final FirebaseFirestore _firestore;
  final Map<String, String> _usernameCache = {};

  UserService(this._firestore);

  Future<String> getUserName(String userId) async {
    if (_usernameCache.containsKey(userId)) {
      return _usernameCache[userId]!;
    }

    try {
      final userDoc = await _firestore
          .collection(FirebaseConstants.usersCollection)
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final userName = userData['name'] as String? ?? 'Anonymous User';
        _usernameCache[userId] = userName;
        return userName;
      } else {
        const userName = 'Unknown User';
        _usernameCache[userId] = userName;
        return userName;
      }
    } catch (e) {
      const userName = 'Anonymous User';
      _usernameCache[userId] = userName;
      return userName;
    }
  }

  void clearCache() {
    _usernameCache.clear();
  }
}