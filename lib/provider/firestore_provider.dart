import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snap_hero/model/player.dart';

class FirestoreProvider {
  static const String COLLECTION_CHALLENGES = 'challenges';
  static const String COLLECTION_PLAYERS = 'players';

  final Firestore _firestore = Firestore.instance;

  Stream<QuerySnapshot> getChallenges() {
    return _firestore.collection(COLLECTION_CHALLENGES).snapshots();
  }

  void completeChallenge(String playerId, String challengeId) async {
    _firestore.collection(COLLECTION_PLAYERS).document(playerId).updateData({
      'completed': FieldValue.arrayUnion([challengeId])
    });
  }

  void createPlayer(String id, String email) async {
    _firestore
        .collection(COLLECTION_PLAYERS)
        .document(id)
        .setData({'email': email, 'completed': FieldValue.arrayUnion([])}, merge: true);
  }

  Future<Player> getPlayer(String playerId) async {
    DocumentSnapshot playerDocument = await _firestore
        .collection(COLLECTION_PLAYERS)
        .document(playerId)
        .get();
    return Player.fromDocument(playerDocument);
  }
}
