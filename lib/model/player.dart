import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String id;
  final List<String> completed;

  Player.fromDocument(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        completed = snapshot['completed'].cast<String>();
}
