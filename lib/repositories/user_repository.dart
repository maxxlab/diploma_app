import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user.dart';
import '../core/constants/firebase_constants.dart';

abstract class UserRepository {
  Future<User> getUserProfile();
  Future<User> updateUserProfile({
    String? name,
    String? profileImage,
  });
}

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  UserRepositoryImpl(this._firestore, this._firebaseAuth);

  @override
  Future<User> getUserProfile() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception('No user is currently signed in');
      }

      final userDoc = await _firestore
          .collection(FirebaseConstants.usersCollection)
          .doc(currentUser.uid)
          .get();

      if (!userDoc.exists) {
        throw Exception('User document not found');
      }

      return User.fromFirestore(userDoc);
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }

  @override
  Future<User> updateUserProfile({
    String? name,
    String? profileImage,
  }) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception('No user is currently signed in');
      }

      final userRef = _firestore
          .collection(FirebaseConstants.usersCollection)
          .doc(currentUser.uid);

      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (profileImage != null) updates['profileImage'] = profileImage;

      await userRef.update(updates);

      final updatedUserDoc = await userRef.get();
      return User.fromFirestore(updatedUserDoc);
    } catch (e) {
      throw Exception('Failed to update user profile: ${e.toString()}');
    }
  }
}