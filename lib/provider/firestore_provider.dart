import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snap_hero/model/player.dart';

class FirestoreProvider {
  final Firestore _firestore = Firestore.instance;

  Stream<QuerySnapshot> getChallenges() {
    return _firestore.collection('challenges').snapshots();
  }

  Future<Player> getPlayer(String playerId) async {
    DocumentSnapshot playerDocument =
        await _firestore.collection('players').document(playerId).get();
    return Player.fromDocument(playerDocument);
  }

  void completeChallenge(String playerId, String challengeId) async {
    _firestore.collection('players').document(playerId).updateData({
      'completed': FieldValue.arrayUnion(List.from({challengeId}))
    });
  }
}
