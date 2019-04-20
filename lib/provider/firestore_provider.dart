import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  final Firestore _firestore = Firestore.instance;

  Stream<QuerySnapshot> getChallenges() {
    return _firestore.collection('challenges').snapshots();
  }
}
