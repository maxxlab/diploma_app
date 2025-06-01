// lib/repositories/report_repository.dart
import 'package:injectable/injectable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/report.dart';

abstract class ReportRepository {
  Future<Report> submitReport(Report report);
  Future<List<Report>> getUserReports();
  Future<List<Report>> getPOIReports(String poiId);
  Future<void> updateReportStatus(String reportId, ReportStatus status);
}

@Injectable(as: ReportRepository)
class ReportRepositoryImpl implements ReportRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  ReportRepositoryImpl(this._firestore, this._firebaseAuth);

  @override
  Future<Report> submitReport(Report report) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final docRef = _firestore.collection('reports').doc();

      final reportWithTimestamps = report.copyWith(
        id: docRef.id,
        userId: currentUser.uid,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await docRef.set(reportWithTimestamps.toJson());
      return reportWithTimestamps;
    } catch (e) {
      throw Exception('Failed to submit report: ${e.toString()}');
    }
  }

  @override
  Future<List<Report>> getUserReports() async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) return [];

      final querySnapshot = await _firestore
          .collection('reports')
          .where('userId', isEqualTo: currentUser.uid)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Report.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get user reports: ${e.toString()}');
    }
  }

  @override
  Future<List<Report>> getPOIReports(String poiId) async {
    try {
      final querySnapshot = await _firestore
          .collection('reports')
          .where('poiId', isEqualTo: poiId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => Report.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get POI reports: ${e.toString()}');
    }
  }

  @override
  Future<void> updateReportStatus(String reportId, ReportStatus status) async {
    try {
      await _firestore
          .collection('reports')
          .doc(reportId)
          .update({
        'status': status.name,
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to update report status: ${e.toString()}');
    }
  }
}