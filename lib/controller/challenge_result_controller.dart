import 'dart:io';
import 'package:snap_hero/provider/vision_provider.dart';
import 'package:snap_hero/provider/firestore_provider.dart';
import 'package:snap_hero/provider/auth_provider.dart';
import 'package:snap_hero/model/challenge.dart';
import 'package:snap_hero/model/challenge_result.dart';

class ChallengeResultController {
  final VisionProvider _visionProvider = VisionProvider();
  final AuthProvider _authProvider = AuthProvider();
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

    if (isSuccess) {
      String userId = await _authProvider.getUserId(); 
      _firestoreProvider.completeChallenge(userId, challenge.id);
    }

    return ChallengeResult(isSuccess: isSuccess, labels: labels);
  }
}
