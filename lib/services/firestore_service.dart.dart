import 'package:cloud_firestore/cloud_firestore.dart';

enum FirestoreCollections {
  Houses,
  Likings,
  Reviews,
  Users
}

class FirestoreService {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getDocument(FirestoreCollections collection, String documentId) async {
  final collectionName = collection.toString().split('.').last;
  try {
    final DocumentSnapshot document = await _firestore.collection(collectionName).doc(documentId).get();
    if (document.exists) {
      return document.data() as Map<String, dynamic>;
    } else {
      print('Document not found');
      return null;
    }
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