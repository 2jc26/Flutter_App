import 'package:cloud_firestore/cloud_firestore.dart';

enum FirestoreCollections {
  Houses,
  Likings,
  Reviews,
  Users
}

class FirestoreService {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot?> getDocument(FirestoreCollections collection, String documentId) async {
    final collectionName = collection.toString().split('.').last;
    try {
      final DocumentSnapshot document = await _firestore.collection(collectionName).doc(documentId).get();
      return document;
    } catch (e) {
      print('Error getting document: $e');
      return null;
    }
  }

  Future<List<DocumentSnapshot>> getAllDocuments(FirestoreCollections collection) async {
    final collectionName = collection.toString().split('.').last;
    try {
      final QuerySnapshot querySnapshot = await _firestore.collection(collectionName).get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error getting documents: $e');
      return [];
    }
  }
}