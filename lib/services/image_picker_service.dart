// lib/services/image_picker_service.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class ImagePickerService {
  final FirebaseStorage _storage;
  final FirebaseAuth _firebaseAuth;
  final ImagePicker _imagePicker;

  ImagePickerService()
      : _storage = FirebaseStorage.instance,
        _firebaseAuth = FirebaseAuth.instance,
        _imagePicker = ImagePicker();

  Future<String?> pickAndUploadProfileImage() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image == null) return null;

      return await _uploadImage(File(image.path), currentUser.uid);
    } catch (e) {
      throw Exception('Failed to pick and upload image: ${e.toString()}');
    }
  }

  Future<String?> captureAndUploadProfileImage() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image == null) return null;

      return await _uploadImage(File(image.path), currentUser.uid);
    } catch (e) {
      throw Exception('Failed to capture and upload image: ${e.toString()}');
    }
  }

  Future<String> _uploadImage(File imageFile, String userId) async {
    try {
      final String fileName = 'profile_$userId.jpg';
      final Reference ref = _storage.ref().child('profile_images').child(fileName);

      final UploadTask uploadTask = ref.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload image: ${e.toString()}');
    }
  }

  Future<void> deleteProfileImage(String userId) async {
    try {
      final String fileName = 'profile_$userId.jpg';
      final Reference ref = _storage.ref().child('profile_images').child(fileName);
      await ref.delete();
    } catch (e) {
      throw Exception('Failed to delete image: ${e.toString()}');
    }
  }
}