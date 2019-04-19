import 'package:cloud_firestore/cloud_firestore.dart';

dynamic getChallenges() {
  return Firestore.instance.collection('challenges').snapshots();
}

