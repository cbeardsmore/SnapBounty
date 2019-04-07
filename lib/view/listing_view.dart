import 'package:flutter/material.dart';
import 'package:snap_hero/widgets/gradient_app_bar.dart';
import 'package:snap_hero/widgets/challenge_list.dart';

class PrimaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppBar('Challenges'),
      ),
      body: ChallengeList()
    );
  }
}
