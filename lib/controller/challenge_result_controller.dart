import 'dart:io';

import 'package:snap_bounty/model/challenge_result.dart';
import 'package:snap_bounty/model/challenge.dart';
import 'package:snap_bounty/model/player.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:snap_bounty/provider/firestore_provider.dart';
import 'package:snap_bounty/provider/vision_provider.dart';

class ChallengeResultController {
  final VisionProvider _visionProvider = VisionProvider();
  final FirestoreProvider _firestoreProvider = FirestoreProvider();

  Future<ChallengeResult> attemptChallenge(
      File image, Challenge challenge) async {
    Map<String, double> labels = await _visionProvider.getLabels(image);
    bool isSuccess = true;
    challenge.labels.forEach((k, v) {
      if (labels[k] == null || labels[k] < challenge.labels[k]) {
        isSuccess = false;
      }
    });

    final AuthProvider _authProvider = AuthProvider();
    String _uid = await _authProvider.getUserId();
    Player _player = await _firestoreProvider.getPlayer(_uid);

    if (isSuccess && !_player.completed.contains(challenge.id)) {
      _firestoreProvider.completeChallenge(_player.id, challenge.id, challenge.xp);
    }

    return ChallengeResult(isSuccess: isSuccess, labels: labels);
  }
}
