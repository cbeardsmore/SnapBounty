import 'package:cloud_firestore/cloud_firestore.dart';

class Challenge {
  final String id;
  final String name;
  final String category;
  final String image;
  final Map<dynamic, dynamic> labels;
  final int xp;

  Challenge.fromDocument(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        name = snapshot['name'],
        category = snapshot['category'],
        image = snapshot['image'],
        labels = snapshot['labels'],
        xp = snapshot['xp'];
}
