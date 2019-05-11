import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String id;
  final List<String> completed;
  final int xp;
  
  String photoUrl;

  Player.fromDocument(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        completed = snapshot['completed'] != null
            ? snapshot['completed'].cast<String>()
            : List(),
        xp = snapshot['xp'];
}
