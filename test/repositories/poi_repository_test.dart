import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tourist_app/models/poi.dart';
import 'package:tourist_app/repositories/poi_repository.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {}
class MockDocumentSnapshot extends Mock implements DocumentSnapshot<Map<String, dynamic>> {}
class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<Map<String, dynamic>> {}
class MockQuery extends Mock implements Query<Map<String, dynamic>> {}
class MockWriteBatch extends Mock implements WriteBatch {}

void main() {
  group('POIRepositoryImpl', () {
    late MockFirebaseFirestore mockFirestore;
    late MockCollectionReference mockCollection;
    late MockDocumentReference mockDocument;
    late MockQuerySnapshot mockQuerySnapshot;
    late MockDocumentSnapshot mockDocumentSnapshot;
    late MockQueryDocumentSnapshot mockQueryDocumentSnapshot;
    late MockWriteBatch mockBatch;
    late POIRepositoryImpl repository;

    final testPOI = POI(
      id: 'test-poi-1',
      name: 'Test Museum',
      description: 'A beautiful test museum',
      category: 'museum',
      location: GeoPoint(49.8417, 24.0318),
      address: 'Test Street 123',
      averageRating: 4.5,
      isAccessible: true,
      priceCategory: 'moderate',
    );

    final testPOIData = {
      'name': 'Test Museum',
      'description': 'A beautiful test museum',
      'category': 'museum',
      'location': GeoPoint(49.8417, 24.0318),
      'address': 'Test Street 123',
      'averageRating': 4.5,
      'isAccessible': true,
      'priceCategory': 'moderate',
      'contactInfo': null,
      'workingHours': null,
      'photos': null,
      'region': null,
      'additionalData': {},
      'createdAt': null,
      'updatedAt': null,
    };

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      mockCollection = MockCollectionReference();
      mockDocument = MockDocumentReference();
      mockQuerySnapshot = MockQuerySnapshot();
      mockDocumentSnapshot = MockDocumentSnapshot();
      mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
      mockBatch = MockWriteBatch();
      repository = POIRepositoryImpl(mockFirestore);

      when(() => mockFirestore.collection('pois')).thenReturn(mockCollection);
    });

    group('getPOIs', () {
      test('returns empty list when no POIs exist', () async {
        when(() => mockQuerySnapshot.docs).thenReturn([]);
        when(() => mockCollection.get()).thenAnswer((_) async => mockQuerySnapshot);

        final result = await repository.getPOIs();

        expect(result, isA<List<POI>>());
        expect(result.isEmpty, isTrue);
        verify(() => mockCollection.get()).called(1);
      });

      test('throws exception when Firestore call fails', () async {
        when(() => mockCollection.get()).thenThrow(Exception('Network error'));

        expect(
              () => repository.getPOIs(),
          throwsA(isA<Exception>().having(
                (e) => e.toString(),
            'message',
            contains('Failed to get POIs'),
          )),
        );
      });
    });

    group('getPOIById', () {

      test('throws exception when Firestore call fails', () async {
        when(() => mockCollection.doc('test-poi-1')).thenReturn(mockDocument);
        when(() => mockDocument.get()).thenThrow(Exception('Network error'));

        expect(
              () => repository.getPOIById('test-poi-1'),
          throwsA(isA<Exception>().having(
                (e) => e.toString(),
            'message',
            contains('Failed to get POI'),
          )),
        );
      });
    });

    group('addPOI', () {
      test('successfully adds POI to Firestore', () async {
        when(() => mockCollection.doc(testPOI.id)).thenReturn(mockDocument);
        when(() => mockDocument.set(any())).thenAnswer((_) async {});

        await repository.addPOI(testPOI);

        verify(() => mockDocument.set(testPOI.toJson())).called(1);
      });

      test('throws exception when add operation fails', () async {
        when(() => mockCollection.doc(testPOI.id)).thenReturn(mockDocument);
        when(() => mockDocument.set(any())).thenThrow(Exception('Permission denied'));

        expect(
              () => repository.addPOI(testPOI),
          throwsA(isA<Exception>().having(
                (e) => e.toString(),
            'message',
            contains('Failed to add POI'),
          )),
        );
      });
    });

    group('updatePOI', () {
      test('successfully updates POI in Firestore', () async {
        when(() => mockCollection.doc(testPOI.id)).thenReturn(mockDocument);
        when(() => mockDocument.update(any())).thenAnswer((_) async {});

        await repository.updatePOI(testPOI);

        verify(() => mockDocument.update(testPOI.toJson())).called(1);
      });

      test('throws exception when update operation fails', () async {
        when(() => mockCollection.doc(testPOI.id)).thenReturn(mockDocument);
        when(() => mockDocument.update(any())).thenThrow(Exception('Document not found'));

        expect(
              () => repository.updatePOI(testPOI),
          throwsA(isA<Exception>().having(
                (e) => e.toString(),
            'message',
            contains('Failed to update POI'),
          )),
        );
      });
    });

    group('deletePOI', () {
      test('successfully deletes POI from Firestore', () async {
        when(() => mockCollection.doc('test-poi-1')).thenReturn(mockDocument);
        when(() => mockDocument.delete()).thenAnswer((_) async {});

        await repository.deletePOI('test-poi-1');

        verify(() => mockDocument.delete()).called(1);
      });

      test('throws exception when delete operation fails', () async {
        when(() => mockCollection.doc('test-poi-1')).thenReturn(mockDocument);
        when(() => mockDocument.delete()).thenThrow(Exception('Permission denied'));

        expect(
              () => repository.deletePOI('test-poi-1'),
          throwsA(isA<Exception>().having(
                (e) => e.toString(),
            'message',
            contains('Failed to delete POI'),
          )),
        );
      });
    });

    group('getPOIsAsGeoJson', () {
      test('converts POI list to valid GeoJSON format', () {
        final pois = [testPOI];

        final result = repository.getPOIsAsGeoJson(pois);

        expect(result, isA<String>());
        expect(result, contains('"type":"FeatureCollection"'));
        expect(result, contains('"features"'));
        expect(result, contains('Test Museum'));
        expect(result, contains('museum'));
      });

      test('returns empty feature collection for empty POI list', () {
        final result = repository.getPOIsAsGeoJson([]);

        expect(result, isA<String>());
        expect(result, contains('"type":"FeatureCollection"'));
        expect(result, contains('"features":[]'));
      });
    });
  });
}