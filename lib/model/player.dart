import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String id;
  final int xp;
  final Timestamp created;
  final Timestamp lastLogin;
  final List<String> completed;

  Player.fromDocument(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        xp = snapshot['xp'],
        created = snapshot['created'],
        lastLogin = snapshot['lastLogin'],
        completed = snapshot['completed'] != null
            ? snapshot['completed'].cast<String>()
            : List();
}
