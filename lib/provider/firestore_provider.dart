import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snap_bounty/model/player.dart';

class FirestoreProvider {
  static const String COLLECTION_CHALLENGES = 'challenges';
  static const String COLLECTION_PLAYERS = 'players';

  final Firestore _firestore = Firestore.instance;

  Stream<QuerySnapshot> getChallenges() {
    return _firestore.collection(COLLECTION_CHALLENGES).snapshots();
  }

  Stream<QuerySnapshot> getFilteredChallenges(filter) {
    return _firestore
        .collection(COLLECTION_CHALLENGES)
        .where('category', isEqualTo: filter)
        .snapshots();
  }

  void completeChallenge(
      String playerId, String challengeId, int challengeXp) async {
    _firestore.collection(COLLECTION_PLAYERS).document(playerId).updateData({
      'completed': FieldValue.arrayUnion([challengeId]),
      'xp': FieldValue.increment(challengeXp)
    });
  }

  void createPlayer(String id, String email) async {
    DocumentSnapshot existing =
        await _firestore.collection(COLLECTION_PLAYERS).document(id).get();
    if (existing.exists) {
      _firestore.collection(COLLECTION_PLAYERS).document(id).setData(
        {
          'lastLogin': Timestamp.now(),
        },
        merge: true,
      );
    } else {
      _firestore.collection(COLLECTION_PLAYERS).document(id).setData(
        {
          'email': email,
          'xp': 0,
          'created': Timestamp.now(),
          'lastLogin': Timestamp.now(),
          'completed': FieldValue.arrayUnion([])
        },
      );
    }
  }

  Future<Player> getPlayer(String playerId) async {
    DocumentSnapshot playerDocument = await _firestore
        .collection(COLLECTION_PLAYERS)
        .document(playerId)
        .get();
    return Player.fromDocument(playerDocument);
  }
}
